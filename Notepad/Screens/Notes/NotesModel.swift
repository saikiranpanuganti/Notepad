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
    var pinnedNotes: [Note] = []
    var notes: [Note] = []
    
    func getData() {
        if let folderName = folderName {
            for item in NotesData.shared.folders {
                if item.name == folderName {
                    folder = item
                    for note in item.notes {
                        if note.pinned {
                            pinnedNotes.append(note)
                        }else {
                            notes.append(note)
                        }
                    }
                    break
                }
            }
        }
    }
    func deleteNote(note: Note?) {
        if let note = note {
            CoreDataManager.deleteNote(note: note)
            refreshNotesData()
            getData()
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
    func getNotesInFolder(folderName: String) -> [Note] {
        return CoreDataManager.fetchNotesOfFolder(folder: folderName) ?? []
    }
}
