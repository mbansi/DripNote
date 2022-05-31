//
//  MoreOptionsViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 14/06/22.
//

import UIKit
import PanModal

class MoreOptionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
}

extension MoreOptionsViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(198)
    }
}
