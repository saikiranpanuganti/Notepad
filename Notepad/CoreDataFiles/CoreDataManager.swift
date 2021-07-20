//
//  CoreDataManager.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 20/07/21.
//

import UIKit
import CoreData

class CoreDataManager {
    static func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let persitanceContainer = appDelegate.persistentContainer
        return persitanceContainer.viewContext
    }
    
    static func fetchAllNotes() -> [Note]? {
        guard let context = getContext() else { return nil}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            if let notes = try context.fetch(fetchRequest) as? [Note] {
                print(notes)
                return notes
            }
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func fetchNotesOfFolder(folder: String) -> [Note]? {
        guard let context = getContext() else { return nil}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "folder == %@", folder)
        
        do {
            if let notes = try context.fetch(fetchRequest) as? [Note] {
                print(notes)
                return notes
            }
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func addNoteToFolder(folder: String? = nil, message: String) {
        guard let context = getContext() else { return }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {return}
        let note = NSManagedObject(entity: entity, insertInto: context)
        note.setValue(folder ?? "Any", forKey: "folder")
        note.setValue(message, forKey: "message")
        note.setValue(UUID().uuidString, forKey: "id")
        note.setValue(Date(), forKey: "date")
        
        do {
            try context.save()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    static func updateNote(message: String, id: String) {
        guard let context = getContext() else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let notes = try context.fetch(fetchRequest)
            if notes.count > 0 {
                if let note = notes[0] as? Note {
                    note.message = message
                    note.date = Date()
                }
            }
        }catch {
            print(error.localizedDescription)
        }
        do {
            try context.save()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteNote(note: Note) {
        guard let context = getContext() else { return }
        
        let itemToRemove = note
        context.delete(itemToRemove)
        
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
