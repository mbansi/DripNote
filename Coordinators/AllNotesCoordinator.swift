//
//  AllNotesCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 20/06/22.
//

import Foundation
import UIKit

class AllNotesCoordinator: Coordinator {
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let allNotes = UIStoryboard(name: "AllNotesScreen", bundle: nil).instantiateViewController(withIdentifier: "AllNotesViewController") as? AllNotesViewController {
            allNotes.hidesBottomBarWhenPushed = false
            allNotes.coordinator = self
            navController?.pushViewController(allNotes, animated: true)
        }
    }
    
    func gotoAddNote(_ delegate: AddNoteDelegateProtocol,_ presenter: UIViewController) {
        if let navController = navController {
            let addNote = AddNoteCoordinator(navController, presenter)
            addNote.startWithData(delegate)
        }
    }
    
    func gotoViewNote(_ delegate: ViewNoteDelegateProtocol,_ note: AllNotesDataModel) {
        if let navController = navController {
            let viewNote = ViewNoteCoordinator(navController)
            viewNote.startWithData(delegate,note)
        }
    }
    
    func gotoEditNote(_ note: AllNotesDataModel) {
        if let navController = navController {
            let editNote = EditNoteCoordinator(navController)
            editNote.startWithData(note)
        }
    }
    
    func finish() {
        navController?.popViewController(animated: true)
    }
    
    func finishToRoot() {
        
    }
}
