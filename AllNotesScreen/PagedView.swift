//
//  PagedView.swift
//  DripNote
//
//  Created by Bansi Mamtora on 01/06/22.
//

import UIKit

protocol PagedViewDelegate {
    func moveToPage(index: Int)
}

class PagedView: UIView {
    init() {
           super.init(frame: .zero)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

     
}


