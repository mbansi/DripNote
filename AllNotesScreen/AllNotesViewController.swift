//
//  AllNotesViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 31/05/22.
//

import UIKit
import PanModal

class AllNotesViewController: UIViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet private weak var editToolbar: UIToolbar!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tblAllNotes: UITableView!
    @IBOutlet private weak var btnFloatingAdd: UIButton!
    @IBOutlet private weak var barbtnDelete: UIBarButtonItem!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    private var allNotesData: [AllNotesDataModel]? = [AllNotesDataModel]()
    private var paginationNotes: [AllNotesDataModel]? = [AllNotesDataModel]()
    private var favoriteNotes: [AllNotesDataModel]? = [AllNotesDataModel]()
    private var displayNotes: [AllNotesDataModel]? = [AllNotesDataModel]()
    private let pageLimit = 8
    private var limit = 8
    private var index = 0
    private var fetchMore: Bool = false
    private var selectedAll: Bool = false
    
    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        //scheduleLocalNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblAllNotes.reloadData()
        let adjustForTabbarInsets = UIEdgeInsets(top: 0, left: 0, bottom: (self.tabBarController?.tabBar.frame.size.height)!, right: 0);
          //  tblAllNotes.contentInset = adjustForTabbarInsets
       // tblAllNotes.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != editToolbar {
            editToolbar.isHidden = true
            btnFloatingAdd.isHidden = false
            tblAllNotes.allowsMultipleSelection = false
            tblAllNotes.reloadData()
        }
    }
    
    //MARK: - Actions
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        tblAllNotes.reloadData()
        tblAllNotes.allowsMultipleSelection = true
        editToolbar.isHidden = false
        btnFloatingAdd.isHidden = true
        selectedAll = true
        if tblAllNotes.indexPathsForSelectedRows == nil {
            barbtnDelete.isEnabled = false
        }
    }
    
    @IBAction func multipleDeleteAction(_ sender: UIBarButtonItem) {
        var position = 0
        if let selectedRows = tblAllNotes.indexPathsForSelectedRows {
            var items: [AllNotesDataModel]? = [AllNotesDataModel]()
            for indexPath in selectedRows  {
                if let note = paginationNotes?[indexPath.row] {
                    items?.insert(note, at: position)
                    position += 1
                }
                
            }
            for item in items ?? [] {
                if let index = paginationNotes?.firstIndex(of: item) {
                    paginationNotes?.remove(at: index)
             //       paginationNotes.remove(at: index)
                }
            }
            
            tblAllNotes.deleteRows(at: selectedRows, with: .right)
            guard let deletedItems = items else { return }
            DatabaseHelper.shared.deleteMultipleNotes(notes: deletedItems)
            barbtnDelete.isEnabled = true
        }
        displayNotes = paginationNotes
        editToolbar.isHidden = true
        btnFloatingAdd.isHidden = false
        tblAllNotes.allowsMultipleSelection = false
        tblAllNotes.reloadData()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectAllRowsAction(_ sender: UIBarButtonItem) {
        if selectedAll {
            for row in 0..<tblAllNotes.numberOfRows(inSection: 0) {
                let selectedIndexPath = IndexPath(row: row, section: 0)
                tblAllNotes.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
            }
            sender.title = "Unselect All"
            selectedAll = false
            barbtnDelete.isEnabled = true
        }
        else {
            for row in 0..<tblAllNotes.numberOfRows(inSection: 0) {
                let selectedIndexPath = IndexPath(row: row, section: 0)
                tblAllNotes.deselectRow(at: selectedIndexPath, animated: true)
            }
            sender.title = "Select All"
            selectedAll = true
            barbtnDelete.isEnabled = false
        }
    }
    
    @IBAction func addNoteAction(_ sender: UIButton) {
        if let addNoteVC = UIStoryboard(name: "AllNotesScreen", bundle: nil).instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController {
            addNoteVC.delegate = self
            self.presentPanModal(addNoteVC)
        }
    }
    
    @IBAction func tabChangedAction(_ sender: UISegmentedControl) {
        sender.changeUnderlinePosition()
        if sender.selectedSegmentIndex == 0 {
            allNotesData = DatabaseHelper.shared.getAllNotes()
            btnFloatingAdd.isHidden = false
        }
        else {
            favoriteNotes = DatabaseHelper.shared.getFavoriteNotes()
            btnFloatingAdd.isHidden = true
        }
        displayNotes = segmentControl.selectedSegmentIndex == 0 ? allNotesData : favoriteNotes
        pagination()
        tblAllNotes.reloadData()
    }
    
    //MARK: - Functions
    func pagination() {
        paginationNotes = [AllNotesDataModel]()
        var index = 0
        guard let count = displayNotes?.count else { return }
        while index < limit && index < count {
            if let note = displayNotes?[index] {
                paginationNotes?.insert(note, at: index)
                index += 1
            }
        }
    }
    
    func configuration() {
        if ((navigationController?.isToolbarHidden) != nil) {
            tblAllNotes.allowsMultipleSelection = false
        }
        activityIndicator.stopAnimating()
        allNotesData = DatabaseHelper.shared.getAllNotes()
        displayNotes = allNotesData
        NotificationManager.shared.scheduleNotification()
        btnFloatingAdd.backgroundColor = R.color.cornflower()
        btnFloatingAdd.layer.cornerRadius = btnFloatingAdd.frame.height / 2
        segmentControl.addUnderlineForSelectedSegment()
        let fontAttributes = [NSAttributedString.Key.font: R.font.montserratRegular(size: 15)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        pagination()
    }
    
    func deleteNote(_ note: AllNotesDataModel) {
        if let index = paginationNotes?.firstIndex(where: { $0 === note }) {
            paginationNotes?.remove(at: index)
            tblAllNotes.deleteRows(at: [IndexPath(row: index, section: 0)], with: .right)
            DatabaseHelper.shared.deleteNote(note: note)
            displayNotes = paginationNotes
        }
    }
}


//MARK: - UITableViewDataSource
extension AllNotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationNotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblAllNotes.dequeueReusableCell(withIdentifier: "allNotesCell", for: indexPath) as? AllNotesTableViewCell else {
            return UITableViewCell()
        }
        fetchMore = true
        if let note = paginationNotes?[indexPath.row] {
            cell.note = note
            cell.configCell(note)
        }
      
        cell.editting = !editToolbar.isHidden ? true : false
       
        cell.delegate = segmentControl.selectedSegmentIndex == 1 ? self : nil
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return editToolbar.isHidden ? true : false
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let displayNotes = displayNotes, let pagedNoted = paginationNotes else { return }
        if paginationNotes != nil {
            if index <= displayNotes.count {
                if indexPath.row == pagedNoted.count - 1 {
                    if pagedNoted.count < displayNotes.count {
                        var index = pagedNoted.count
                        limit = index + pageLimit
                        while index < limit && index < displayNotes.count {
                            paginationNotes?.append(displayNotes[index])
                            index += 1
                        }
                        activityIndicator.startAnimating()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.tblAllNotes.reloadData()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension AllNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tblAllNotes.dequeueReusableCell(withIdentifier: "allNotesCell", for: indexPath) as? AllNotesTableViewCell else {
            return
        }
        if !editToolbar.isHidden {
            barbtnDelete.isEnabled = true
        }   else {
            if !tblAllNotes.allowsMultipleSelection {
                      if let viewNote = UIStoryboard(name: "ViewNoteScreen", bundle: nil).instantiateViewController(withIdentifier: "ViewNoteViewController") as? ViewNoteViewController {
                          viewNote.modalPresentationStyle = .overCurrentContext
                          mainView.alpha = 0.5
                          viewNote.delegate = self
                          guard let note = paginationNotes?[indexPath.row] else { return }
                          viewNote.note = note
                          present(viewNote, animated: true, completion: nil)
                      }
                  }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self] (action,view,completion) in
            guard let self = self else {
                return
            }
            self.showAlert(title: "Delete", message: "Are you sure you want to delete this note?") {
                if let note = self.paginationNotes?[indexPath.row] {
                    self.deleteNote(note)
                }
            }
        }
        deleteAction.image = R.image.deleteIcon()
        deleteAction.backgroundColor = R.color.deleteBackgroundColor()
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - CellDelegate
extension AllNotesViewController: CellDelegate {
    func removeFromFavorites(note: AllNotesDataModel) {
        if let index = favoriteNotes?.firstIndex(where: { $0 === note }) {
            DatabaseHelper.shared.updateFavorite(favStatus: false, note: note)
            favoriteNotes?.remove(at: index)
            paginationNotes = favoriteNotes
            tblAllNotes.deleteRows(at: [IndexPath(row: index, section: 0)], with: .right)
        }
    }
}

//MARK: - AddNoteDelegateProtocol
extension AllNotesViewController: AddNoteDelegateProtocol {
    func noteAdded(_ note: AllNotesDataModel) {
        let position = 0
        paginationNotes?.insert(note, at: position)
        let indexPath = IndexPath(row: 0, section: 0)
        tblAllNotes.insertRows(at: [indexPath], with:.left)
        DatabaseHelper.shared.addNote(note: note)
        if paginationNotes?.count == 1 {
            NotificationManager.shared.scheduleNotification()
        }
    }
}

extension AllNotesViewController: ViewNoteDelegateProtocol {
    func pushEditNote(_ note: AllNotesDataModel) {
        if let editNote = UIStoryboard(name: "EditNoteScreen", bundle: nil).instantiateViewController(withIdentifier: "EditNoteViewController") as? EditNoteViewController {
                              editNote.oldNote = note
                              self.navigationController?.pushViewController(editNote, animated: true)
          //  self.present(editNote, animated: true)
                          }
    }
    
    func exitViewNote() {
        mainView.alpha = 1
    }
}
