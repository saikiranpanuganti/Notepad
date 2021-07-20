//
//  FoldersViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class FoldersViewController: UIViewController {
    @IBOutlet weak var foldersView: FoldersView!
    var foldersModel: FoldersModel = FoldersModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foldersView.delegate = self
        foldersView.setUpUI()
        foldersView.folders = foldersModel.folders
        foldersView.updateUI()
    }
    func createFolder(folderName: String) {
        foldersModel.createNewFolder(folderName: folderName)
        foldersView.folders = foldersModel.folders
        foldersView.updateUI()
    }
    func showAlertController() {
        let alertController = UIAlertController(title: "Create a folder", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Enter folder name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { alert in
            if let firstTextfield = alertController.textFields?[0] {
                if let text = firstTextfield.text, text.replacingOccurrences(of: " ", with: "") != "" {
                    self.createFolder(folderName: text)
                }
            }
        }
        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension FoldersViewController: FoldersViewDelegate {
    func addNotesTapped() {
        let controller = Controller.addNotes.getViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    func addFolderTapped() {
        showAlertController()
    }
    func folderTapped(folder: Folder) {
        if let controller = Controller.notes.getViewController() as? NotesViewController {
            controller.notesModel.folder = folder
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
