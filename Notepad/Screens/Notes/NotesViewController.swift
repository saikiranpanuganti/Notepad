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
        notesModel.getData()
        notesView.folder = notesModel.folder
        notesView.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesModel.getData()
        notesView.folder = notesModel.folder
        notesView.updateUI()
    }
}

extension NotesViewController: NotesViewDelegate {
    func editNotes(note: Note?) {
        if let controller = Controller.addNotes.getViewController() as? AddNotesViewController {
            controller.addNotesModel.folder = notesModel.folder
            controller.addNotesModel.note = note
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    func addTapped() {
        if let controller = Controller.addNotes.getViewController() as? AddNotesViewController {
            controller.addNotesModel.folder = notesModel.folder
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
