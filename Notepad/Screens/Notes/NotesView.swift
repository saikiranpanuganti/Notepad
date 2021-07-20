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
    
    var folder: Folder?
    
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        searchScope.image = Images.shared.scope
        searchView.layer.cornerRadius = 10.0
        
        title.text = folder?.name ?? ""
        
        let redPlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Colors.shared.searchText])
        searchTextField.attributedPlaceholder = redPlaceholderText
        
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
        delegate?.backTapped()
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        delegate?.addTapped()
    }
}

extension NotesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folder?.notes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell {
            cell.configureUI(note: folder?.notes[indexPath.row])
        }
        return UITableViewCell()
    }
}
extension NotesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
