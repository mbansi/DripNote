//
//  GenericFunctions.swift
//  DripNote
//
//  Created by Bansi Mamtora on 10/06/22.
//

import Foundation
import UIKit


extension UIViewController {
    func showAlert(title: String, message: String,action:@escaping () -> Void ){
        let alert = UIAlertController(title: "Alert", message:   message , preferredStyle: UIAlertController.Style.alert)
        let positive = UIAlertAction(title: title, style: .default) { _ in
            action()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(positive)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}

