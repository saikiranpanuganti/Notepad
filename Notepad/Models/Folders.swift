//
//  Folders.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 20/07/21.
//

import Foundation

struct Folder {
    var name: String
    var notes: [Note]
    var isMain: Bool = false
}

class NotesData {
    private init() { }
    
    static let shared: NotesData = NotesData()
    
    var folders: [Folder] = []
}
