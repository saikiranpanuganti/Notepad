//
//  NotesModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class NotesModel {
    var folderName: String?
    var folder: Folder?
    
    func getData() {
        if let folderName = folderName {
            for item in NotesData.shared.folders {
                if item.name == folderName {
                    folder = item
                }
            }
        }
    }
}
