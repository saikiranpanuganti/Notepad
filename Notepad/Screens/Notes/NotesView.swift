//
//  NotesView.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

protocol NotesViewDelegate: AnyObject {
    func backTapped()
    func addTapped()
    func updateNote(note: Note?)
    func delete(note: Note?)
}

class NotesView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchScope: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var title: UILabel!
    
    weak var delegate: NotesViewDelegate?
    var isEditingMode: Bool = false
    
    var folder: Folder?
    var pinnedNotes: [Note] = []
    var notes: [Note] = []
    
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        searchScope.image = Images.shared.scope
        searchView.layer.cornerRadius = 10.0
        
        title.text = folder?.name ?? ""
        
        let redPlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Colors.shared.searchText])
        searchTextField.attributedPlaceholder = redPlaceholderText
        searchTextField.delegate = self
        
        addView.layer.cornerRadius = 30
        
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    @IBAction func backTapped() {
        searchTextField.resignFirstResponder()
        delegate?.backTapped()
    }
    @IBAction func addTapped(_ sender: UIButton) {
        delegate?.addTapped()
    }
    @IBAction func editTapped(_ sender: UIButton) {
        isEditingMode = !isEditingMode
        updateUI()
    }
}

extension NotesView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pinnedNotes.count
        }else {
            return notes.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell {
                cell.delegate = self
                cell.configureUI(note: pinnedNotes[indexPath.row])
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell {
                cell.delegate = self
                cell.configureUI(note: notes[indexPath.row])
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
extension NotesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditingMode {
            searchTextField.resignFirstResponder()
            if indexPath.section == 0 {
                delegate?.updateNote(note: pinnedNotes[indexPath.row])
            }else {
                delegate?.updateNote(note: notes[indexPath.row])
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell {
            if section == 0 {
                headerView.configureUI(title: "Pinned Notes")
            }else {
                headerView.configureUI(title: "Notes")
            }
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if pinnedNotes.count == 0 {
                return 0
            }
        }else if section == 1 {
            if notes.count == 0 {
                return 0
            }
        }
        return 30
    }
}
extension NotesView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension NotesView: NoteTableViewCellDelegate {
    func deleteTapped(note: Note?) {
        delegate?.delete(note: note)
    }
    func pinTapped(note: Note?) {
        
    }
}
