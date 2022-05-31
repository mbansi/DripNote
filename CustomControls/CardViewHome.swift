//
//  CardViewHome.swift
//  DripNote
//
//  Created by Bansi Mamtora on 02/06/22.
//

import UIKit

class CardViewHome: UIView {

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
    private func setup() {
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.cornerRadius = 15
    }
    

}
