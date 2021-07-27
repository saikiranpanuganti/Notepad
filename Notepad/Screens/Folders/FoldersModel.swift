//
//  FoldersModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class FoldersModel {
    var folders: [String] = [] //"Folder1", "Folder2", "Folder3"
    var noteCountArray: [Int] = [] //  1, 5, 1, 2, 0
    
    func getData() {
        if let folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
            folders = folderNames
        }
        
        var notesArray: [Int] = []
        for folderName in folders {
            let notes = CoreDataManager.fetchNotesOfFolder(folder: folderName)
            notesArray.append(notes?.count ?? 0)
        }
        
        noteCountArray = notesArray
    }
    func createFolder(folderName: String) {
        folders.append(folderName)
        UserDefaults.standard.setValue(folders, forKey: "folders")
    }
}
