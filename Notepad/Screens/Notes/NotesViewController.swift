//
//  NotesViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var notesView: NotesView!
    var notesModel: NotesModel = NotesModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        notesView.delegate = self
        notesView.folder = notesModel.folder
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
