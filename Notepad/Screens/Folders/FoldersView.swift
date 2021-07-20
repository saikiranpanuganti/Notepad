//
//  FoldersView.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

protocol FoldersViewDelegate: AnyObject {
    func folderTapped(folder: Folder)
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
    
    var folders: [Folder] = []
    
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        searchScope.image = Images.shared.scope
        searchView.layer.cornerRadius = 10.0
        
        let redPlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Colors.shared.searchText])
        searchTextField.attributedPlaceholder = redPlaceholderText
        
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
        delegate?.addFolderTapped()
    }
    @IBAction func addNotesTapped(_ sender: UIButton) {
        delegate?.addNotesTapped()
    }
}

extension FoldersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell {
            cell.configureUI(mainCell: folders[indexPath.row].isMain, folder: folders[indexPath.row].name, notesCount: folders[indexPath.row].notes.count)
            return cell
        }
        return UITableViewCell()
    }
}
extension FoldersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.folderTapped(folder: folders[indexPath.row])
    }
}
