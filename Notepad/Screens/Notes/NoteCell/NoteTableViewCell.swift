//
//  NoteTableViewCell.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 21/07/21.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var radioView: UIView!
    @IBOutlet weak var radioImage: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    func setUpUI() {
        deleteView.isHidden = true
        radioView.isHidden = true
        deleteImage.tintColor = Colors.shared.redColor
        radioImage.tintColor = Colors.shared.redColor
        seperator.backgroundColor = Colors.shared.lightGrey
        dateLabel.textColor = Colors.shared.searchText
    }
    func configureUI(note: Note?, isEditingMode: Bool) {
        if isEditingMode {
            arrowView.isHidden = true
            UIView.animate(withDuration: 0.3) {
                self.deleteView.isHidden = false
                self.radioView.isHidden = false
            }
        }else {
            arrowView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.deleteView.isHidden = true
                self.radioView.isHidden = true
            }
        }
        messageLabel.text = note?.message ?? ""
        dateLabel.text = note?.date?.convertToDateString(formatType: .DDMMYY) ?? ""
    }
}
