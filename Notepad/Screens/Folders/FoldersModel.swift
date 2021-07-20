//
//  FoldersModel.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

class FoldersModel {
    var folders: [Folder] = []
    
    func createNewFolder(folderName: String) {
        if var folderNames = UserDefaults.standard.value(forKey: "folders") as? [String] {
            folderNames.append(folderName)
            UserDefaults.standard.setValue(folderNames, forKey: "folders")
        }else {
            UserDefaults.standard.setValue([folderName], forKey: "folders")
        }
        folders.append(Folder(name: folderName, notes: [], isMain: false))
    }
}
