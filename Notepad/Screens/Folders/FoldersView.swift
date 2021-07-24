//
//  FoldersView.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

protocol FoldersViewDelegate: AnyObject {
    func folderTapped()
    func addNotesTapped()
    func addFolderTapped()
}

class FoldersView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchScope: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addView: UIView!
    
    weak var delegate: FoldersViewDelegate?
    var isEditing: Bool = false
    var editingIndexPath: IndexPath?
        
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        searchScope.image = Images.shared.scope
        searchView.layer.cornerRadius = 10.0
        
        let redPlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Colors.shared.searchText])
        searchTextField.attributedPlaceholder = redPlaceholderText
        searchTextField.delegate = self
        
        addView.layer.cornerRadius = 30
        
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        
        tableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    func updateUI() {
        tableView.reloadData()
    }
    
    @IBAction func addFolderTapped() {
        searchTextField.resignFirstResponder()
        delegate?.addFolderTapped()
    }
    @IBAction func addNotesTapped(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        delegate?.addNotesTapped()
    }
}

extension FoldersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var isMainCell: Bool = false
        if indexPath.row == 0 {
            isMainCell = true
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell {
            cell.configureUI(mainCell: isMainCell, folder: "folder \(String(indexPath.row))", notesCount: indexPath.row, indexPath: indexPath)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}
extension FoldersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.resignFirstResponder()
        delegate?.folderTapped()
    }
}
extension FoldersView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension FoldersView: NotesTableViewCellDelegate {
    
}
