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
    func saveNote(message: String)
}

class AddNotesView: UIView {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageView: UITextView!
    
    weak var delegate: AddNotesViewDelegate?
    
    var date: Date?
    var message: String = ""
    
    func setUpUI() {
        dateLabel.text = Date().getFormattedDate()
        
    }
    func updateUI() {
        messageView.text = message
    }
    
    @IBAction func backTapped() {
        delegate?.saveNote(message: messageView.text)
        delegate?.backTapped()
    }
    @IBAction func deleteTapped() {
        delegate?.deleteTapped()
    }
    @IBAction func shareTapped() {
        delegate?.shareTapped()
    }
}
