//
//  AddNotesViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class AddNotesViewController: UIViewController {
    @IBOutlet weak var addNotesView: AddNotesView!
    var viewModel: AddNotesViewModel = AddNotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotesView.delegate = self
    }
    
}

extension AddNotesViewController: AddNotesViewDelegate {
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    func deleteTapped() {
        
    }
    func shareTapped() {
        
    }
}
