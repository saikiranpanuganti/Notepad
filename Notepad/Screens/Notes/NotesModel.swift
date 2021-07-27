//
//  NotesModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class NotesModel {
    var folderName: String = ""
    var notes: [Note] = []
    
    func fetchNotes() {
        notes = CoreDataManager.fetchNotesOfFolder(folder: folderName) ?? []
    }
}
