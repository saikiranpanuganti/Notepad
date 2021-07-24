//
//  HeaderTableViewCell.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 24/07/21.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pinnedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    func setUpUI() {
        topView.backgroundColor = Colors.shared.notesSection
        titleLabel.textColor = Colors.shared.white
    }
    func configureUI(title: String, pinned: Bool) {
        if !pinned {
            pinnedImage.isHidden = true
        }
        titleLabel.text = title
    }
}
