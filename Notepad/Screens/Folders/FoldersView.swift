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
    func deleteFolder(folder: String?)
    func changeFolderNameTapped(folder: Folder?)
}

class FoldersView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchScope: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var cancelSearch: UIButton!
    
    weak var delegate: FoldersViewDelegate?
    var isEditing: Bool = false
    var editingIndexPath: IndexPath?
    
    var folders: [Folder] = []
    var isSearching: Bool = false
    var searchArray: [Folder] = []
    
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        searchScope.image = Images.shared.scope
        searchView.layer.cornerRadius = 10.0
        
        let redPlaceholderText = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Colors.shared.searchText])
        searchTextField.attributedPlaceholder = redPlaceholderText
        searchTextField.delegate = self
        
        cancelSearch.isHidden = true
        
        addView.layer.cornerRadius = 30
        
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        
        tableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    func updateUI() {
        tableView.reloadData()
    }
    func clearSearch() {
        searchTextField.text = ""
        cancelSearch.isHidden = true
        isSearching = false
    }
    @IBAction func addFolderTapped() {
        searchTextField.resignFirstResponder()
        delegate?.addFolderTapped()
    }
    @IBAction func addNotesTapped(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        delegate?.addNotesTapped()
    }
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text, text.replacingOccurrences(of: " ", with: "") != "" {
            cancelSearch.isHidden = false
            isSearching = true
            searchArray = []
            for folder in folders {
                if folder.name.localizedCaseInsensitiveContains(text) {
                    searchArray.append(folder)
                }
            }
            updateUI()
        }else {
            isSearching = false
            clearSearch()
            updateUI()
        }
    }
    @IBAction func cancelSearchTapped(_ sender: UIButton) {
        clearSearch()
        updateUI()
    }
}

extension FoldersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchArray.count
        }
        return folders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell {
            if isSearching{
                cell.configureUI(mainCell: searchArray[indexPath.row].isMain, folder: searchArray[indexPath.row], notesCount: searchArray[indexPath.row].notes.count, indexPath: indexPath)
            }else {
                cell.configureUI(mainCell: folders[indexPath.row].isMain, folder: folders[indexPath.row], notesCount: folders[indexPath.row].notes.count, indexPath: indexPath)
            }
            
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
        if isSearching {
            clearSearch()
            delegate?.folderTapped(folder: searchArray[indexPath.row])
        }else {
            delegate?.folderTapped(folder: folders[indexPath.row])
        }
    }
}
extension FoldersView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension FoldersView: NotesTableViewCellDelegate {
    func deleteTapped(folder: String?) {
        print("FoldesView deleteTapped")
        delegate?.deleteFolder(folder: folder)
    }
    
    func changeFolderNameTapped(folder: Folder?) {
        delegate?.changeFolderNameTapped(folder: folder)
    }
}
