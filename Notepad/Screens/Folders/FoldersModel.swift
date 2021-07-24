//
//  FoldersModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class FoldersModel {
    var folders: [Folder] {
        return NotesData.shared.folders
    }
    
    func createNewFolder(folderName: String) {
        if var folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
            folderNames.append(folderName)
            UserDefaults.standard.setValue(folderNames, forKey: "folders")
        }else {
            UserDefaults.standard.setValue([folderName], forKey: "folders")
        }
        NotesData.shared.folders.append(Folder(name: folderName, notes: [], isMain: false))
    }
    func getNotesInFolder(folderName: String) -> [Note] {
        return CoreDataManager.fetchNotesOfFolder(folder: folderName) ?? []
    }
    func deleteFolder(folder: String?) {
        if let folder = folder {
            CoreDataManager.deleteFolder(folder: folder)
            removeFolderFromUserDefaults(folder: folder)
            refreshNotesData()
        }
    }
    func changeFolderNameTapped(folder: Folder?, folderName: String) {
        if let folder = folder {
            CoreDataManager.updateFolderName(folder: folder, folderName: folderName)
            if var folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
                for (index, name) in folderNames.enumerated() {
                    if name == folder.name {
                        folderNames.remove(at: index)
                        folderNames.append(folderName)
                        UserDefaults.standard.setValue(folderNames, forKey: "folders")
                        refreshNotesData()
                        break
                    }
                }
            }
        }
    }
    func removeFolderFromUserDefaults(folder: String) {
        if var folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
            for (index, folderName) in folderNames.enumerated() {
                if folderName == folder {
                    folderNames.remove(at: index)
                    UserDefaults.standard.setValue(folderNames, forKey: "folders")
                    break
                }
            }
        }
    }
    func refreshNotesData() {
        var folders: [Folder] = []
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
}
