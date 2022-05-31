//
//  BaseButtonGrey.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class BaseButtonGrey: UIButton {

    //MARK: - init
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Functions
    func setup() {
        self.titleLabel?.textColor = .gray
        self.titleLabel?.font = R.font.niveauGroteskRegular(size: 20)
    }
}
