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
    }
}

extension FoldersViewController: FoldersViewDelegate {
    func addTapped() {
        let controller = Controller.addNotes.getViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    func folderTapped() {
        let controller = Controller.notes.getViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
