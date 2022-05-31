//
//  AddNoteCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 21/06/22.
//

import Foundation
import UIKit

class AddNoteCoordinator: Coordinator {
    var navController: UINavigationController?
    var presenter: UIViewController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    convenience init(_ navigationController: UINavigationController, _ presenter: UIViewController) {
        self.init(navigationController)
        self.presenter = presenter
    }
    
    func start() {
        
    }
    
    func startWithData(_ delegate: AddNoteDelegateProtocol) {
        if let addNoteVC = UIStoryboard(name: "AllNotesScreen", bundle: nil).instantiateViewController(withIdentifier:  "AddNoteViewController") as? AddNoteViewController {
            addNoteVC.coordinator = self
            addNoteVC.delegate = delegate
            presenter?.presentPanModal(addNoteVC)
        }
    }
    
    func finishWithData(_ delegate: AddNoteDelegateProtocol,_ note: AllNotesDataModel) {
        delegate.noteAdded(note)
        presenter?.dismiss(animated: true)
    }
    
    func finish() {
        presenter?.dismiss(animated: true)
    }
    
    func finishToRoot() {
        
    }
}
