//
//  IconStackView.swift
//  DripNote
//
//  Created by Bansi Mamtora on 15/06/22.
//

import UIKit

class IconStackView: UIView {
    
    @IBOutlet weak var btnShow: UIButton!
    
    @IBOutlet weak var stackIcons: UIStackView!
    @IBOutlet var otherIconCollection: [UIButton]!
    
    //MARK: - init
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        guard let view = self.loadFromNib(nibName: "IconStackView") else { return }
        view.frame = self.bounds
        otherIconCollection.forEach{ btn in
            btn.isHidden = true
        }
        self.addSubview(view)
    }
    
    @IBAction func showIcons(_ sender: UIButton) {
        otherIconCollection.forEach{ btn in
            UIView.animate(withDuration: 0.5,delay: 0,options: .curveEaseIn){[weak self] in
                self?.btnShow.alpha = 0
                btn.isHidden = !btn.isHidden
                self?.stackIcons.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func hideIcons(_ sender: UIButton) {
        otherIconCollection.forEach{ btn in
            UIView.animate(withDuration: 0.5,delay: 0,options: .curveEaseIn
            ){ [weak self] in
                self?.btnShow.alpha = 1
                btn.isHidden = !btn.isHidden
                self?.stackIcons.layoutIfNeeded()
            }
        }
    }
}


