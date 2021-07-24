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
        foldersModel.getData()
        let data = foldersModel.folders
        foldersView.folders = data
        foldersView.updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func showAlertController() {
        let alertController = UIAlertController(title: "Create a folder", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Enter folder name"
        }
        // MARK: - Add alert Button
        let addAction = UIAlertAction(title: "Add", style: .default) { alert in
            if let firstTextfield = alertController.textFields?[0] {
                if let text = firstTextfield.text, text.replacingOccurrences(of: " ", with: "") != "" {
                    // MARK: - Create a tableview cell with this name
                    self.createFolder(folderName: text)
                }
            }
        }
        alertController.addAction(addAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func createFolder(folderName: String) {
        foldersModel.createFolder(folderName: folderName)
        let data = foldersModel.folders
        foldersView.folders = data
        foldersView.updateUI()
    }
}

extension FoldersViewController: FoldersViewDelegate {
    func navigateToNotesController(folderName: String) {
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController {
            controller.notesModel.folderName = folderName
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    func addFolderTapped() {
        showAlertController()
    }
}
