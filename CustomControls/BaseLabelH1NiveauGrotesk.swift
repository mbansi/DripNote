//
//  BaseLabelH1NiveauGrotesk.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class BaseLabelH1NiveauGrotesk: UILabel {
    
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
        self.textColor = R.color.cornflower()
        self.font = UIFont(name: "Montserrat-Regular", size: 50)
    }
    
}
