//
//  HomeCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 20/06/22.
//

import Foundation
import UIKit

class TabCoordinator: Coordinator {
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let tabVC = UIStoryboard(name: "HomeScreen", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as? TabViewController {
            tabVC.coordinator = self
            navController?.pushViewController(tabVC, animated: true)
        }
    }
    
    func finish() {
        navController?.popViewController(animated: true)
    }
    
    func finishToRoot() {
        
    }
}
