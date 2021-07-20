//
//  AddNotesModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class AddNotesModel {
    var folder: String?
    
    func saveNote(message: String) {
        CoreDataManager.addNoteToFolder(folder: folder, message: message)
    }
}
