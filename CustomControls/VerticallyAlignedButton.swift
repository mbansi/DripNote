//
//  VerticallyAlignedButton.swift
//  DripNote
//
//  Created by Bansi Mamtora on 14/06/22.
//

import UIKit

class VerticallyAlignedButton: UIButton {

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
        self.setTitleColor(UIColor.gray, for: .normal)
        self.titleLabel?.font = R.font.montserratRegular(size: 14)
    }

}
