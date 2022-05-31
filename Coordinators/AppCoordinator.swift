//
//  AppCoordinator.swift
//  DripNote
//
//  Created by Bansi Mamtora on 20/06/22.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator {
    
    //MARK: - Variables
    var navController: UINavigationController?
    
    //MARK: - Functions
    init(_ navigationController: UINavigationController) {
        navController = navigationController
        navController?.navigationBar.isHidden = true
    }
    
    func start() {
        if let navController = navController {
            let splash = SplashCoordinator(navController)
            splash.start()
        }
    }
    
    func finish() {
        navController?.popViewController(animated: true)
    }
    
    func finishToRoot() {
        //to pop to rootview controller
    }
    
}
