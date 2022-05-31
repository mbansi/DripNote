//
//  HomeCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 21/06/22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let homeVC = UIStoryboard(name: "HomeScreen", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            homeVC.coordinator = self
            
        }
    }
    
    func gotoAllNotes() {
        if let navController = navController {
            let allNotes = AllNotesCoordinator(navController)
            allNotes.start()
        }
    }
    
    func finish() {
        
    }
    
    func finishToRoot() {
        
    }
    
    
}
