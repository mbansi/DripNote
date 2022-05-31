//
//  BaseButtonWhite.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class BaseButtonWhite: BaseButtonPrimaryColor {
    
    //MARK: - init
    override init(frame: CGRect){
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    //MARK: - Functions
    func setupButton() {
        self.backgroundColor = .white
        self.titleLabel?.textColor = R.color.cornflower()
    }
}
