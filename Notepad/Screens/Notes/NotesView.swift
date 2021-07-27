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
    
    var folderName: String = ""
    var notesData: [Note] = []
    
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        searchScope.image = Images.shared.scope
        searchView.layer.cornerRadius = 10.0
        
        title.text = folderName
        
        let redPlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Colors.shared.searchText])
        searchTextField.attributedPlaceholder = redPlaceholderText
        searchTextField.delegate = self
        
        addView.layer.cornerRadius = 30
        
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell {
            cell.configureUI(note: notesData[indexPath.row])
            cell.delegate = self
            return cell
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
        }
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
}
