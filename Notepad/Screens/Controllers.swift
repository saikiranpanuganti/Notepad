//
//  Controllers.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import Foundation

import UIKit

enum Controller {
    case splash
    case folders
    case notes
    case addNotes
    
    func getViewController() -> UIViewController {
        
        var storyBoardId = ""
        var controllerId = ""
        
        switch self {
        case .splash:
            storyBoardId = "Main"
            controllerId = "SplashViewController"
        case .folders:
            storyBoardId = "Main"
            controllerId = "FoldersViewController"
        case .notes:
            storyBoardId = "Main"
            controllerId = "NotesViewController"
        case .addNotes:
            storyBoardId = "Main"
            controllerId = "AddNotesViewController"
        }
        
        let storyboard = UIStoryboard(name: storyBoardId, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: controllerId)
        return controller
    }
}
