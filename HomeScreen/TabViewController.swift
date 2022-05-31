//
//  TabViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 16/06/22.
//

import UIKit

class TabViewController: UITabBarController {

    weak var coordinator: TabCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue
        self.tabBarController?.tabBar.standardAppearance = appearance
        
        if let navController = self.navigationController {
            coordinator = TabCoordinator(navController)
        }
    }
}
