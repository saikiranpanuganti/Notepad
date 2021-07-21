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
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: AddNotesViewDelegate?
    
    var note: Note?
    
    func setUpUI() {
        navBarHeightConstraint.constant = topSafeAreaHeight + 40
        dateLabel.text = Date().convertToLongString()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        
        messageView.becomeFirstResponder()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    func updateUI() {
        if note != nil {
            messageView.text = note?.message
            dateLabel.text = note?.date?.convertToLongString()
        }
    }
    @objc func handleTap() {
        messageView.resignFirstResponder()
    }
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = self.convert(keyboardScreenEndFrame, from: self.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            messageView.contentInset = .zero
        } else {
            messageView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - self.safeAreaInsets.bottom, right: 0)
        }

        messageView.scrollIndicatorInsets = messageView.contentInset

        let selectedRange = messageView.selectedRange
        messageView.scrollRangeToVisible(selectedRange)
    }
    @IBAction func backTapped() {
        messageView.resignFirstResponder()
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
