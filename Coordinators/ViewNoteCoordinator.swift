//
//  ViewNoteCoordinators.swift
//  DripNote
//
//  Created by Bansi Mamtora on 21/06/22.
//

import Foundation
import UIKit

class ViewNoteCoordinator: Coordinator {
    
    var navController: UINavigationController?
 
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        
    }
    
    func startWithData(_ delegate: ViewNoteDelegateProtocol,_ note: AllNotesDataModel) {
        if let viewNoteVC = UIStoryboard(name: "ViewNoteScreen", bundle: nil).instantiateViewController(withIdentifier: "ViewNoteViewController") as? ViewNoteViewController {
            viewNoteVC.modalPresentationStyle = .overCurrentContext
            viewNoteVC.delegate = delegate
            viewNoteVC.note = note
            viewNoteVC.coordinator = self
            navController?.viewControllers.last?.present(viewNoteVC, animated: true)
        }
    }
    
    func finish() {
        
        navController?.viewControllers.last?.dismiss(animated: true)
        print("finished")
    }
    
    func finishToRoot() {
        
    }
    
    
}
