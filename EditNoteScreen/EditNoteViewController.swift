//
//  EditNoteViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 03/06/22.
//

import UIKit

class EditNoteViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var txtDetail: UITextView!
    
    @IBOutlet weak var btnFav: UIButton!
    lazy var oldNote: AllNotesDataModel = {
        return AllNotesDataModel()
    }()
    lazy var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        
        if isFavorite {
            sender.setImage(R.image.dropIcon(), for: .normal)
            isFavorite = false
        }
        else {
            sender.setImage(R.image.coloredDropIcon(), for: .normal)
            isFavorite = true
        }
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        guard let title = txtTitle.text, let detail = txtDetail.text else {
            return
        }
        let newNote = AllNotesDataModel(noteId: oldNote.noteId, title: title, detail: detail, favorite: isFavorite)
        DatabaseHelper.shared.updateNote(oldNote: oldNote, newNote: newNote)
        navigationController?.popViewController(animated: true)
    }
    
    func configuration() {
      
            txtTitle.text = oldNote.title
            txtDetail.text = oldNote.detail
            btnFav.setImage(oldNote.favorite ? R.image.coloredDropIcon() : R.image.dropIcon(), for: .normal)
        isFavorite = oldNote.favorite

    }
}
