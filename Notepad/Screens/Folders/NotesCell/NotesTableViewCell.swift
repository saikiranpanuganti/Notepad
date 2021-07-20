//
//  NotesTableViewCell.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var numberOfNotes: UILabel!
    @IBOutlet weak var seperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    func setUpUI() {
        seperator.backgroundColor = Colors.shared.lightGrey
    }
    func configureUI(mainCell: Bool, folder: String, notesCount: Int) {
        if mainCell {
            folderImage.tintColor = Colors.shared.redColor
            folderName.textColor = Colors.shared.redColor
            folderImage.image = UIImage(systemName: "archivebox")
        }else {
            folderImage.tintColor = Colors.shared.folder
            folderName.textColor = Colors.shared.white
            folderImage.image = UIImage(systemName: "folder")
        }
        folderName.text = folder
        numberOfNotes.text = String(notesCount)
    }
}
