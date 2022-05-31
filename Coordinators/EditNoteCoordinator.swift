//
//  EditNoteCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 21/06/22.
//

import Foundation
import UIKit

class EditNoteCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
       
    }
    
    func startWithData(_ note: AllNotesDataModel) {
        if let editNoteVC = UIStoryboard(name: "EditNoteScreen", bundle: nil).instantiateViewController(withIdentifier: "EditNoteViewController") as? EditNoteViewController {
            editNoteVC.oldNote = note
            navController?.pushViewController(editNoteVC, animated: true)
        }
    }
    
    func finish() {
        
    }
    
    func finishToRoot() {
        
    }
    
}
