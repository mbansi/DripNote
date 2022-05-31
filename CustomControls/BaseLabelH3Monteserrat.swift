//
//  BaseLabelH3Monteserrat.swift
//  DripNote
//
//  Created by Bansi Mamtora on 30/05/22.
//

import UIKit

class BaseLabelH3Monteserrat: UILabel {

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
        self.textColor = .black
        self.font = UIFont(name: "Montserrat-Regular", size: 16)
        
        let paragraphStyle = NSMutableParagraphStyle()
        //line height size
        paragraphStyle.lineSpacing = 5
        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
        self.textAlignment = NSTextAlignment.center
    }

}
