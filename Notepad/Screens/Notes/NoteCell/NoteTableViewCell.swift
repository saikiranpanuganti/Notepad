//
//  NoteTableViewCell.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 21/07/21.
//

import UIKit

protocol NoteTableViewCellDelegate : AnyObject {
    func deleteTapped(note: Note?)
}

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteImage: UIImageView!
    
    weak var delegate: NoteTableViewCellDelegate?
    var note: Note?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    func setUpUI() {
        deleteView.isHidden = true
        deleteImage.tintColor = Colors.shared.redColor
        seperator.backgroundColor = Colors.shared.lightGrey
        dateLabel.textColor = Colors.shared.searchText
        print("")
    }
    func toggleDeleteButton(isEditingMode: Bool) {
        DispatchQueue.main.async {
            if isEditingMode {
                UIView.animate(withDuration: 0.3) {
                    self.deleteView.isHidden = false
                }
            }else {
                UIView.animate(withDuration: 0.3) {
                    self.deleteView.isHidden = true
                }
            }
        }
    }
    func configureUI(note: Note?) {
        self.note = note
        messageLabel.text = note?.message ?? ""
        dateLabel.text = note?.date?.convertToDateString(formatType: .DDMMYY) ?? ""
    }
    @IBAction func deleteTapped(_ sender: UIButton) {
        delegate?.deleteTapped(note: note)
    }
}
