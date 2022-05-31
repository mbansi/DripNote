//
//  BaseLabelH4Monteserrat.swift
//  DripNote
//
//  Created by Bansi Mamtora on 01/06/22.
//

import UIKit

class BaseLabelH4Monteserrat: BaseLabelH3Monteserrat {

    //MARK: - init
    override init(frame: CGRect){
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    //MARK: - Functions


    func setupLabel() {
        self.textColor = .black
        self.font = UIFont(name: "Montserrat-Regular", size: 15)

        self.textAlignment = NSTextAlignment.justified
    }
}
