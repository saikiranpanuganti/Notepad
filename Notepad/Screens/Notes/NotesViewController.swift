//
//  NotesViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var notesView: NotesView!
    var viewModel: NotesViewModel = NotesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        notesView.delegate = self
        notesView.setUpUI()
    }
}

extension NotesViewController: NotesViewDelegate {
    func addTapped() {
        let controller = Controller.addNotes.getViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
