//
//  AddNoteViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 02/06/22.
//

import UIKit
import RealmSwift

protocol AddNoteDelegateProtocol {
    func noteAdded(_ note: AllNotesDataModel)
}

class AddNoteViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var btnFullScreen: UIButton!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var btnShow: UIButton!
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet var otherIconsCollection: [UIButton]!
    
    //MARK: - Variables
    var delegate: AddNoteDelegateProtocol? = nil
    var favoriteStatus: Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNote.textContainerInset = UIEdgeInsets(top: 29, left: 32, bottom: 50, right: 51)
        otherIconsCollection.forEach{ btn in
            btn.isHidden = true
        }
        btnDrop.setImage(R.image.dropIcon(), for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func fullScreenAction(_ sender: UIButton) {
        if sender.image(for: .normal) == R.image.smallScreenIcon() {
            self.sheetPresentationController?.detents = [.medium()]
            btnFullScreen.setImage(R.image.fullScreenIcon(), for: .normal)
        }
        else {
            btnFullScreen.setImage(R.image.smallScreenIcon(), for: .normal)
            self.sheetPresentationController?.detents = [.large()]
        }
    }
    
    @IBAction func hideAction(_ sender: UIButton) {
        otherIconsCollection.forEach{ btn in
            UIView.animate(withDuration: 0.5,delay: 0,options: .curveLinear
            ){ [weak self] in
                self?.btnShow.alpha = 1
                btn.isHidden = !btn.isHidden
                btn.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func showAction(_ sender: UIButton) {
        otherIconsCollection.forEach{ btn in
            UIView.animate(withDuration: 0.5,delay: 0,options: .curveEaseIn){[weak self] in
                self?.btnShow.alpha = 0
                btn.isHidden = !btn.isHidden
                btn.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        toggleFavorite()
    }
    
    @IBAction func uploadAction(_ sender: UIButton) {
        if !txtNote.text.isEmpty {
            let note = AllNotesDataModel(noteId: UUID(),title: txtNote.text, detail: txtNote.text,favorite: favoriteStatus)
            
            self.delegate?.noteAdded(note)
            self.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message:   "Empty note caanot be saved" , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - Functions
    func toggleFavorite() {
        favoriteStatus = btnDrop.image(for: .normal) == R.image.dropIcon() ? false : true
        if favoriteStatus {
            btnDrop.setImage(R.image.dropIcon(), for: .normal)
            favoriteStatus = false
        }
        else {
            btnDrop.setImage(R.image.coloredDropIcon(), for: .normal)
            favoriteStatus = true
        }
    }
}
