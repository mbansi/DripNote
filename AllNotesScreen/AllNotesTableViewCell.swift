//
//  AllNotesTableViewCell.swift
//  DripNote
//
//  Created by Bansi Mamtora on 01/06/22.
//

import UIKit

protocol CellDelegate: AnyObject {
    func removeFromFavorites(note: AllNotesDataModel)
}

class AllNotesTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet private weak var btnFav: UIButton!
    @IBOutlet weak var btnSelected: UIButton!
    @IBOutlet private weak var lblNoteDetails: BaseLabelH5Monteserrat!
    @IBOutlet private weak var lblNote: BaseLabelH4Monteserrat!
    @IBOutlet weak var cardView: CardViewHome!
    
    //MARK: - Variables
    weak var note: AllNotesDataModel?
    private var favStatus: Bool = false
    var editting: Bool = false
    weak var delegate: CellDelegate?
    
    //MARK: - Functions
    func configCell(_ data: AllNotesDataModel) {
        lblNote.text = data.title
        lblNoteDetails.text = data.detail
        note = data
        if !editting {
            btnSelected.isHidden = true
            btnFav.isHidden = false
            cardView.backgroundColor = .white
        }
        if data.favorite {
            btnFav.setImage(R.image.coloredDropIcon(), for: .normal)
        }
        else {
            btnFav.setImage(R.image.dropIcon(), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if editting {
            btnFav.isHidden = true
            btnSelected.isHidden = false
            if selected {
                btnSelected.setImage(R.image.selectedRowIcon(), for: .normal)
                cardView .backgroundColor = R.color.selectedRowColor()
            }
            else {
                btnSelected.setImage(R.image.unselectedRow(), for: .normal)
                cardView.backgroundColor = .white
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let note = note else {
            return
        }
        if note.favorite {
            sender.setImage(R.image.dropIcon(), for: .normal)
            favStatus = false
        }
        else {
            sender.setImage(R.image.coloredDropIcon(), for: .normal)
            favStatus = true
            
        }
        self.delegate?.removeFromFavorites(note: note)
        DatabaseHelper.shared.updateFavorite(favStatus: favStatus, note: note)
    }
}
