//
//  AddNotesViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class AddNotesViewController: UIViewController {
    @IBOutlet weak var addNotesView: AddNotesView!
    var addNotesModel: AddNotesModel = AddNotesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotesView.delegate = self
        addNotesView.setUpUI()
        addNotesView.note = addNotesModel.note
        addNotesView.updateUI()
    }
    func popController() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddNotesViewController: AddNotesViewDelegate {
    func saveNote(message: String) {
        if message.replacingOccurrences(of: " ", with: "") != "" {
            addNotesModel.saveNote(message: message)
        }
    }
    func backTapped() {
        popController()
    }
    func deleteTapped() {
        addNotesModel.deleteNote()
        popController()
    }
    func shareTapped() {
        
    }
}
