//
//  SplashCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 20/06/22.
//

import Foundation
import UIKit

class SplashCoordinator: Coordinator {
    
    var navController: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        navController = navigationController
    }
    
    func start() {
        if let splashVC = UIStoryboard(name: "SplashScreen", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController {
            splashVC.coordinator = self
            navController?.pushViewController(splashVC, animated: true)
        }
    }
    
    func gotoHome() {
        if let navController = navController {
            let home = TabCoordinator(navController)
            home.start()
        }
    }
    
    func finish() {
        
    }
    
    func finishToRoot() {
        
    }
}
