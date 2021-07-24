//
//  NotesTableViewCell.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

protocol NotesTableViewCellDelegate: AnyObject {
    
}

class NotesTableViewCell: UITableViewCell {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var numberOfNotes: UILabel!
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var folderButton: UIButton!
    @IBOutlet weak var buttonStackWidth: NSLayoutConstraint!
    @IBOutlet weak var stackLeadingConstraint: NSLayoutConstraint!
    
    weak var delegate: NotesTableViewCellDelegate?
    var swipeRight: Bool = true
    var menuPanelCollapsed: Bool = true
    var isEditOn: Bool = false
    var postedNotification: Bool = false
    var folder: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        addPanGesture()
        buttonStackWidth.constant = 0
        stackLeadingConstraint.constant = 30
        NotificationCenter.default.addObserver(self, selector:#selector(editingNotification(_:)), name: NSNotification.Name("EditInfoNotification"), object: nil)
    }
    func setUpUI() {
        folderName.textColor = .white
        seperator.backgroundColor = Colors.shared.lightGrey
        numberOfNotes.layer.cornerRadius = 10.0
        numberOfNotes.layer.borderWidth = 2.0
        numberOfNotes.layer.borderColor = Colors.shared.notesCount.cgColor
    }
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        topView.addGestureRecognizer(panGesture)
    }
    
    func configureUI(folder: String) {
        folderName.text = folder
    }
//    func configureUI(mainCell: Bool, folder: String, notesCount: Int, indexPath: IndexPath) {
//        if mainCell {
//            folderImage.tintColor = Colors.shared.redColor
//            folderName.textColor = Colors.shared.redColor
//            folderImage.image = UIImage(systemName: "archivebox")
//        }else {
//            folderImage.tintColor = Colors.shared.folder
//            folderName.textColor = Colors.shared.white
//            folderImage.image = UIImage(systemName: "folder")
//        }
//        folderName.text = folder
//        numberOfNotes.text = String(notesCount)
//        self.folder = folder
//    }
    func postEditInfoNotification() {
        postedNotification = true
        NotificationCenter.default.post(name: NSNotification.Name("EditInfoNotification"), object: nil, userInfo: nil)
    }
    @IBAction func deleteTapped(_ sender: UIButton) {
        hideStack(duration: 0.3)
    }
    @IBAction func pingTapped(_ sender: UIButton) {
        hideStack(duration: 0.3)
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
                buttonStackWidth.constant = -translation.x
                stackLeadingConstraint.constant = 30 + translation.x
            }else {
                buttonStackWidth.constant = 118 - translation.x
                stackLeadingConstraint.constant = -88 + translation.x
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
}
