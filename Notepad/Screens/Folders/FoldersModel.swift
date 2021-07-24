//
//  FoldersModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class FoldersModel {
    var folders: [String] = []
    
    func getData() {
        if let folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
            folders = folderNames
        }
    }
    func createFolder(folderName: String) {
        folders.append(folderName)
        UserDefaults.standard.setValue(folders, forKey: "folders")
    }
}
