//
//  CardView.swift
//  DripNote
//

//  Created by Bansi Mamtora on 31/05/22.

import UIKit

class CardView: UIView {
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
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.cornerRadius = 15
    }
}

