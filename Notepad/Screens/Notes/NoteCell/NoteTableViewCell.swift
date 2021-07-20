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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }
    func setUpUI() {
        seperator.backgroundColor = Colors.shared.lightGrey
        dateLabel.textColor = Colors.shared.searchText
    }
    func configureUI(note: Note?) {
        messageLabel.text = note?.message ?? ""
        dateLabel.text = note?.date?.convertToDateString(formatType: .DDMMYY) ?? ""
    }
}
