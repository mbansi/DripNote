//
//  HomeTableViewCell.swift
//  DripNote
//
//  Created by Bansi Mamtora on 31/05/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTitle: BaseLabelH3Monteserrat!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHomeDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Functions
    func configCell(_ data: HomeModel) {
        lblTitle.text = data.title
        imgHome.image = UIImage(named: "home")
        lblHomeDetails.text = data.detail
        
//        cardView.layer.shadowRadius = 2
//        cardView.layer.shadowColor = UIColor.black.cgColor
//        cardView.layer.shadowOpacity = 0.2
//        cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
//        cardView.layer.cornerRadius = 15
    }
}
