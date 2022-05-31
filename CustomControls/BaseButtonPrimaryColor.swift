//
//  BaseButtonFilled.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class BaseButtonPrimaryColor: UIButton {

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
        self.titleLabel?.textColor = .black
        self.layer.cornerRadius = 25
        self.layer.backgroundColor = R.color.cornflower()?.cgColor
        self.titleLabel?.font = R.font.montserratRegular(size: 14)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.gray.cgColor
    }

}
