//
//  NoteTableViewCell.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 21/07/21.
//

import UIKit

protocol NoteTableViewCellDelegate : AnyObject {
    func deleteTapped(note: Note?)
    func pinTapped(note: Note?)
}

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var buttonStackWidth: NSLayoutConstraint!
    @IBOutlet weak var stackLeadingConstraint: NSLayoutConstraint!
    
    weak var delegate: NoteTableViewCellDelegate?
    var swipeRight: Bool = true
    var menuPanelCollapsed: Bool = true
    var isEditOn: Bool = false
    var postedNotification: Bool = false
    var note: Note?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        addPanGesture()
        buttonStackWidth.constant = 0
        stackLeadingConstraint.constant = 30
        NotificationCenter.default.addObserver(self, selector:#selector(editingNotification(_:)), name: NSNotification.Name("EditInfoNotification"), object: nil)
    }
    func setUpUI() {
        seperator.backgroundColor = Colors.shared.lightGrey
        dateLabel.textColor = Colors.shared.searchText
    }
    func configureUI(note: Note?, pinned: Bool) {
        self.note = note
        messageLabel.text = note?.message ?? ""
        dateLabel.text = note?.date?.convertToDateString(formatType: .DDMMYY) ?? ""
        if pinned {
            pinButton.setImage(UIImage(systemName: "pin.slash.fill"), for: .normal)
        }else {
            pinButton.setImage(UIImage(systemName: "pin.fill"), for: .normal)
        }
    }
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        panGesture.delegate = self
        topView.addGestureRecognizer(panGesture)
    }
    func postEditInfoNotification() {
        postedNotification = true
        NotificationCenter.default.post(name: NSNotification.Name("EditInfoNotification"), object: nil, userInfo: nil)
    }
    @objc func editingNotification(_ notification: Notification){
        if isEditOn && !postedNotification {
            hideStack(duration: 0.3)
        }
        postedNotification = false
    }
    @objc func panGesture(_ sender : UIPanGestureRecognizer) {
        let piece = sender.view
        let translation = sender.translation(in: piece?.superview)
        let velocity = sender.velocity(in: piece?.superview)
        if sender.state == .began{
            postEditInfoNotification()
        }else if sender.state == .changed {
            if velocity.x > 0 {
                swipeRight = true
                if stackLeadingConstraint.constant >= 30 {
                    return
                }
            }else {
                swipeRight = false
            }
            
            if menuPanelCollapsed {
                if -translation.x < 0 {
                    buttonStackWidth.constant = 0
                    stackLeadingConstraint.constant = 30
                }else {
                    buttonStackWidth.constant = -translation.x
                    stackLeadingConstraint.constant = 30 + translation.x
                }
            }else {
                if 118 - translation.x < 0 {
                    buttonStackWidth.constant = 0
                    stackLeadingConstraint.constant = 30
                }else {
                    buttonStackWidth.constant = 118 - translation.x
                    stackLeadingConstraint.constant = -88 + translation.x
                }
            }
            
            topView.layoutIfNeeded()
        }else if sender.state == .ended {
            if swipeRight {
                let stackWidth = self.buttonStackWidth.constant
                let duration: Double = 0.4*Double(stackWidth)/120
                hideStack(duration: duration)
                isEditOn = false
            }else {
                let stackWidth = 120 - self.buttonStackWidth.constant
                let duration: Double = 0.4*Double(stackWidth)/120
                unHideStack(duration: duration)
                isEditOn = true
            }
        }
    }
    func hideStack(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.buttonStackWidth.constant = 0
            self.stackLeadingConstraint.constant = 30
            self.topView.layoutIfNeeded()
        }) { (true) in
            self.menuPanelCollapsed = true
        }
    }
    func unHideStack(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.buttonStackWidth.constant = 118
            self.stackLeadingConstraint.constant = 30 - 118
            self.topView.layoutIfNeeded()
        }) { (true) in
            self.menuPanelCollapsed = false
        }
    }
    @IBAction func deleteTapped(_ sender: UIButton) {
        hideStack(duration: 0)
        delegate?.deleteTapped(note: note)
    }
    @IBAction func pinTapped(_ sender: UIButton) {
        hideStack(duration: 0)
        delegate?.pinTapped(note: note)
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: superview)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
        }
        return false
    }
}
