//
//  UIView.swift
//  DripNote
//
//  Created by Bansi Mamtora on 15/06/22.
//

import Foundation
import UIKit

extension UIView {
    func loadFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
