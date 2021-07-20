//
//  AddNotesView.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

protocol AddNotesViewDelegate: AnyObject {
    func backTapped()
    func deleteTapped()
    func shareTapped()
    func saveNote()
}

class AddNotesView: UIView {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var messageView: UITextView!
    
    weak var delegate: AddNotesViewDelegate?
    
    var message: String = ""
    
    func setUpUI() {
        date.text = Date().getFormattedDate()
    }
    func updateUI() {
        messageView.text = message
    }
    
    @IBAction func backTapped() {
//        delegate?.saveNote()
        delegate?.backTapped()
    }
    @IBAction func deleteTapped() {
        delegate?.deleteTapped()
    }
    @IBAction func shareTapped() {
        delegate?.shareTapped()
    }
}
