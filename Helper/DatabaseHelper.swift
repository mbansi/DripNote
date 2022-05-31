//
//  DatabaseHelper.swift
//  DripNote
//
//  Created by Bansi Mamtora on 02/06/22.
//

import UIKit
import RealmSwift

class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    
    var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch {
                print("Could not access database: ", error)
            }
            return self.realm
        }
    }
    
    func getDatabaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func addNote(note: AllNotesDataModel) {
        do {
            try realm.write() {
                realm.add(note)
            }
        } catch {
            print("Something went wrong!")
        }
    }
    
    func getAllNotes() -> [AllNotesDataModel] {
        return Array(realm.objects(AllNotesDataModel.self)).reversed()
    }
    
    func deleteNote(note: AllNotesDataModel) {
        do {
            try realm.write() {
                realm.delete(note)
            }
        } catch {
            print("Something went wrong!")
        }
    }
    
    func deleteMultipleNotes(notes: [AllNotesDataModel]) {
        do {
            try realm.write() {
                realm.delete(notes)
            }
        } catch {
            print("Something went wrong!")
        }
    }

    func updateFavorite(favStatus: Bool,note: AllNotesDataModel) {
        do {
            try realm.write() {
                note.favorite = favStatus
            }
        } catch {
            print("Something went wrong!")
        }
    }
    
    func getFavoriteNotes() -> [AllNotesDataModel] {
        let objects = realm.objects(AllNotesDataModel.self)
        let favorites = objects.where {
            $0.favorite == true
        }
        return Array(favorites).reversed()
    }

    func updateNote(oldNote: AllNotesDataModel, newNote: AllNotesDataModel) {
            do {
               try realm.write() {
                   oldNote.title = newNote.title
                   oldNote.detail = newNote.detail
                   oldNote.favorite = newNote.favorite
               }
            } catch {
                print("Something went wrong!")
            }
        }
}
