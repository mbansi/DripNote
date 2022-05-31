//
//  SplashViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func loginAction(_ sender: BaseButtonWhite) {
        if let homeVC = UIStoryboard(name: "HomeScreen", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
}
