//
//  ViewNoteViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 03/06/22.
//

import UIKit
protocol ViewNoteDelegateProtocol {

    func pushEditNote(_ note: AllNotesDataModel)
    func exitViewNote()
}

class ViewNoteViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDetail: UITextView!
    @IBOutlet weak var btnFav: UIButton!
    
    //MARK: - Variables
    var delegate: ViewNoteDelegateProtocol? = nil
    var note = AllNotesDataModel()
    weak var coordinator: ViewNoteCoordinator?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == mainView {
            coordinator?.finish()
            
            self.delegate?.exitViewNote()
        }
    }
    
    //MARK: - Action
    
    @IBAction func doneAction(_ sender: ButtonMonteserrat12) {
        self.delegate?.exitViewNote()
//        self.dismiss(animated: true)
            self.coordinator?.finish()
       
        
    }
    
    @IBAction func settingsAction(_ sender: UIButton) {
        if let moreSettings = UIStoryboard(name: "ViewNoteScreen", bundle: nil).instantiateViewController(withIdentifier: "MoreOptionsViewController") as? MoreOptionsViewController {
            self.presentPanModal(moreSettings)
        }
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        
    }
    
    @IBAction func flagAction(_ sender: UIButton) {
        
    }
    
    @IBAction func editAction(_ sender: BaseButtonPrimaryColor) {
        self.dismiss(animated: true)
                            // noteView.alpha = 0
        self.delegate?.exitViewNote()
                self.delegate?.pushEditNote(note)
    }
    
    //MARK: - Functions
    func configuration() {
        txtDetail.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 10, right: 20)
        lblTitle.text = note.title
        txtDetail.text = note.detail
        btnFav.setImage(note.favorite ? R.image.coloredDropIcon() : R.image.dropIcon(), for: .normal)
    }
}
