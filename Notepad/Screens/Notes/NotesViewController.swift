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
        let folderName = notesModel.folderName
        notesView.folderName = folderName
        notesView.setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesView.updateUI()
    }
}

extension NotesViewController: NotesViewDelegate {
    func delete(note: Note?) {
        notesView.updateUI()
        
    }
    func updateNote(note: Note?) {
        if let controller = Controller.addNotes.getViewController() as? AddNotesViewController {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    func addTapped() {
        if let controller = Controller.addNotes.getViewController() as? AddNotesViewController {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
