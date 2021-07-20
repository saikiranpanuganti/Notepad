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
    
    var note: Note?
    
    func setUpUI() {
        dateLabel.text = Date().getFormattedDate()
        
    }
    func updateUI() {
        if note != nil {
            messageView.text = note?.message
            dateLabel.text = note?.date?.getFormattedDate()
        }
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
