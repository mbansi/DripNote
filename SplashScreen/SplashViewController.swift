//
//  SplashViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - Variables
    var coordinator: SplashCoordinator?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navController = self.navigationController {
            coordinator = SplashCoordinator(navController)
        }
    }
    
    //MARK: - Actions
    @IBAction func loginAction(_ sender: BaseButtonWhite) {
        coordinator?.gotoHome()
    }
    
}
