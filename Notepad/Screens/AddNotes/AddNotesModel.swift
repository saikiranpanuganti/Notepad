//
//  AddNotesModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class AddNotesModel {
    var folderName: String = ""
    
    func saveNote(message: String) {
        CoreDataManager.addNoteToFolder(folder: folderName, message: message)
    }
}
