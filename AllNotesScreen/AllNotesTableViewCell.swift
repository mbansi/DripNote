//
//  AllNotesTableViewCell.swift
//  DripNote
//
//  Created by Bansi Mamtora on 01/06/22.
//

import UIKit

class AllNotesTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblNoteDetails: BaseLabelH5Monteserrat!
    @IBOutlet weak var lblNote: BaseLabelH4Monteserrat!
    
    lazy var note = AllNotesDataModel()
    var favStatus: Bool = false
    
    func configCell(_ data: AllNotesDataModel) {
        if data.title != nil {
            lblNote.text = data.title
        }
        else {
            lblNote.text = data.detail
        }
        lblNoteDetails.text = data.detail
        note = data
        if data.favorite {
            btnFav.setImage(R.image.coloredDropIcon(), for: .normal)
        }
        else {
            btnFav.setImage(R.image.dropIcon(), for: .normal)
        }
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        if note.favorite {
            sender.setImage(R.image.dropIcon(), for: .normal)
            favStatus = false
        }
        else {
            sender.setImage(R.image.coloredDropIcon(), for: .normal)
            favStatus = true
            
        }
        DatabaseHelper.shared.updateFavorite(favStatus: favStatus, note: note)
    }
}
