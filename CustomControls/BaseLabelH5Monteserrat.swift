//
//  BaseLabelH5Monteserrat.swift
//  DripNote
//
//  Created by Bansi Mamtora on 01/06/22.
//

import UIKit

class BaseLabelH5Monteserrat: BaseLabelH4Monteserrat {

    //MARK: - init
    override init(frame: CGRect){
        super.init(frame: frame)
        setupDetail()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDetail()
    }
    
    //MARK: - Functions
    private func setupDetail() {
        self.font = UIFont(name: "Montserrat-Regular", size: 15)
//        let string = self.text ?? ""
//        let number = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
//        let attributes = [NSAttributedString.Key.foregroundColor: R.color.cornflower()]
//        let attributedQuote = NSAttributedString(string: String(number ?? 0) , attributes: attributes)
//        self.attributedText = attributedQuote
//        self.textColor = .black
    }
}
