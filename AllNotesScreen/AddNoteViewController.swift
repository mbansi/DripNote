//
//  AddNoteViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 02/06/22.
//

import UIKit
import RealmSwift
import PanModal

protocol AddNoteDelegateProtocol {
    func noteAdded(_ note: AllNotesDataModel)
}

class AddNoteViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet private weak var btnFullScreen: UIButton!
    @IBOutlet private weak var txtNote: UITextView!
    @IBOutlet private weak var btnDrop: UIButton!
    @IBOutlet weak var iconsViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Variables
    var delegate: AddNoteDelegateProtocol? = nil
    private var favoriteStatus: Bool = false
    private var fullScreenView: Bool = false
    private var keyboardOpen: Bool = false
    private lazy var keyboardHeight = CGFloat()
    private var placeholder = "e.g., the mitochondria is the powerhouse of the cell"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        txtNote.textContainerInset = UIEdgeInsets(top: 29, left: 32, bottom: 50, right: 51)
        btnDrop.setImage(R.image.dropIcon(), for: .normal)
        txtNote.text = placeholder
        txtNote.textColor = .gray
        txtNote.delegate = self
    }
    
    //MARK: - Functions
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            iconsViewBottomConstraint.constant = keyboardSize.height + 5
            keyboardHeight = keyboardSize.height
            self.view.layoutIfNeeded()
        }
        keyboardOpen = true
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardOpen = false
        iconsViewBottomConstraint.constant = 0
        self.view.layoutIfNeeded()
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtNote.textColor == UIColor.gray {
            txtNote.text = ""
            txtNote.textColor = UIColor.black
        }
    }
    
    //MARK: - Actions
    @IBAction func fullScreenAction(_ sender: UIButton) {
        if fullScreenView {
            btnFullScreen.setImage(R.image.fullScreenIcon(), for: .normal)
            fullScreenView = false
            panModalSetNeedsLayoutUpdate()
            panModalTransition(to: .longForm)
            
        } else {
            btnFullScreen.setImage(R.image.smallScreenIcon(), for: .normal)
            fullScreenView = true
            panModalSetNeedsLayoutUpdate()
            panModalTransition(to: .longForm)
        }
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        if favoriteStatus {
            btnDrop.setImage(R.image.dropIcon(), for: .normal)
            favoriteStatus = false
        }
        else {
            btnDrop.setImage(R.image.coloredDropIcon(), for: .normal)
            favoriteStatus = true
        }
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
}

//MARK: - PanModalPresentable
extension AddNoteViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return fullScreenView ? .maxHeight : (keyboardOpen ? .contentHeight(keyboardHeight+186) : .contentHeight(186))
    }
}
