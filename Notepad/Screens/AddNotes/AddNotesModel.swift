//
//  AddNotesModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class AddNotesModel {
    var folder: Folder?
    var note: Note?
    var updateNeeded: Bool {
        if note != nil {
            return true
        }
        return false
    }
    func deleteNote() {
        if let note = note {
            CoreDataManager.deleteNote(note: note)
            refreshNotesData()
        }
    }
    func saveNote(message: String) {
        if updateNeeded {
            CoreDataManager.updateNote(message: message, id: note?.id ?? "")
            refreshNotesData()
        }else {
            CoreDataManager.addNoteToFolder(folder: folder?.name, message: message)
            refreshNotesData()
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
