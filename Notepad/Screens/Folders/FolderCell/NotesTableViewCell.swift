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
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    func setUpUI() {
        deleteView.isHidden = true
        deleteImage.tintColor = Colors.shared.redColor
        seperator.backgroundColor = Colors.shared.lightGrey
        numberOfNotes.layer.cornerRadius = 10.0
        numberOfNotes.layer.borderWidth = 2.0
        numberOfNotes.layer.borderColor = Colors.shared.notesCount.cgColor
    }
    func toggleDeleteButton(isEditingMode: Bool) {
        DispatchQueue.main.async {
            if isEditingMode {
                UIView.animate(withDuration: 0.2) {
                    self.deleteView.isHidden = false
                }
            }else {
                UIView.animate(withDuration: 0.2) {
                    self.deleteView.isHidden = true
                }
            }
        }
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
    @IBAction func deleteTapped(_ sender: UIButton) {
        
    }
}
