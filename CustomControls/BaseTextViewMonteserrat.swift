//
//  BaseTextViewMonteserrat.swift
//  DripNote
//
//  Created by Bansi Mamtora on 02/06/22.
//

import UIKit

class BaseTextViewMonteserrat: UITextView {

    //MARK: - init
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Functions
    func setup() {
        self.textColor = .black
        self.font = UIFont(name: "Montserrat-Regular", size: 15)
    }

}
