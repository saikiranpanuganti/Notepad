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
        addNotesView.updateUI()
    }
    
}

extension AddNotesViewController: AddNotesViewDelegate {
    func saveNote(message: String) {
        if message.replacingOccurrences(of: " ", with: "") != "" {
            
        }
    }
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    func deleteTapped() {
        
    }
    func shareTapped() {
        
    }
}
