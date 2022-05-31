//
//  ButtonMonteserrat12.swift
//  DripNote
//
//  Created by Bansi Mamtora on 03/06/22.
//

import UIKit

class ButtonMonteserrat12: UIButton {

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
        self.setTitleColor(R.color.cornflower(), for: .normal)
    }
}
