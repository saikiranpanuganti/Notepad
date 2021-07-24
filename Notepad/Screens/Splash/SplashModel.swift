//
//  SplashModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 20/07/21.
//

import Foundation

class SplashModel {
    var folders: [Folder] = []
    
    func getFolders() {
        if let folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
            for folderName in folderNames {
                let notes = getNotesInFolder(folderName: folderName)
                folders.append(Folder(name: folderName, notes: notes))
            }
        }
        
        var allNotes: [Note] = []
        for folder in folders {
            allNotes = allNotes + folder.notes
        }
        allNotes = allNotes + getNotesInFolder(folderName: "All Notes")
        
        folders.insert(Folder(name: "All Notes", notes: allNotes, isMain: true), at: 0)
        
        NotesData.shared.folders = folders
    }
    
    func getNotesInFolder(folderName: String) -> [Note] {
        return CoreDataManager.fetchNotesOfFolder(folder: folderName) ?? []
    }
}
