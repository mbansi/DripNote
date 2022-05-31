//
//  AllNotesViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 31/05/22.
//

import UIKit
import PanModal

protocol Presentable {
    var string: String { get }
    var type: UIViewController & PanModalPresentable { get }
}

class AllNotesViewController: UIViewController,AddNoteDelegateProtocol {
    
    //MARK: - Outlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tblAllNotes: UITableView!
    @IBOutlet weak var btnFloatingAdd: UIButton!
    
    //MARK: - Variables
    var allNotesData = [AllNotesDataModel]()
    var favoriteStatus: Bool = false
    private var paginationNotes = [AllNotesDataModel]()
    var favoriteNotes = [AllNotesDataModel]()
    private var displayNotes = [AllNotesDataModel]()
    private let pageLimit = 8
    private var limit = 8
    private var index = 0
    private var indexpath = IndexPath()
    
    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }
    
    //MARK: - Actions
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        tblAllNotes.allowsMultipleSelection = true
        self.navigationController?.setToolbarHidden(false, animated: false)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(didPressDelete))
        self.toolbarItems = [ deleteButton]
        self.navigationController?.toolbar.barTintColor = UIColor.white
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNoteAction(_ sender: UIButton) {
        if let addNoteVC = UIStoryboard(name: "AllNotesScreen", bundle: nil).instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController {
            if let sheet = addNoteVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 20
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            addNoteVC.delegate = self
            self.present(addNoteVC, animated: true)
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
        // tblAllNotes.reloadRows(at: [indexpath], with: .automatic)
        tblAllNotes.reloadData()
    }
    
    //MARK: - Functions
    
    func noteAdded(_ note: AllNotesDataModel) {
        let position = 0
        paginationNotes.insert(note, at: position)
        let indexPath = IndexPath(row: position, section: 0)
        tblAllNotes.insertRows(at: [indexPath], with:.left)
        DatabaseHelper.shared.addNote(note: note)
    }
    
    func pagination() {
        paginationNotes = [AllNotesDataModel]()
        var index = 0
        while index < limit && index < displayNotes.count {
            paginationNotes.append(displayNotes[index])
            index += 1
        }
    }
    
    func configuration() {
      
        if ((navigationController?.isToolbarHidden) != nil) {
            tblAllNotes.allowsMultipleSelection = false
        }
        allNotesData = DatabaseHelper.shared.getAllNotes()
        displayNotes = allNotesData
        
        tblAllNotes.backgroundColor = R.color.homeBackground()
        btnFloatingAdd.layer.masksToBounds = true
        btnFloatingAdd.backgroundColor = R.color.cornflower()
        btnFloatingAdd.layer.cornerRadius = btnFloatingAdd.frame.height / 2
        segmentControl.addUnderlineForSelectedSegment()
        
        let fontAttributes = [NSAttributedString.Key.font: R.font.montserratRegular(size: 15)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        pagination()
        
    }
    
    @objc func didPressDelete() {
        var deletingNotes = [AllNotesDataModel]()
        if let selectedRows = self.tblAllNotes.indexPathsForSelectedRows {
            for var selectionIndex in selectedRows {
                while selectionIndex.row >= paginationNotes.count {
                    selectionIndex.row -= 1
                }
                deletingNotes.append(paginationNotes[selectionIndex.row])
                paginationNotes.remove(at: selectionIndex.row)
                
            }
            tblAllNotes.deleteRows(at: selectedRows, with: .fade)
            DatabaseHelper.shared.deleteMultipleNotes(notes: deletingNotes)
        }
    }
    
    func showAlert(_ title: String,_ message: String,_ view: UIViewController, indexPath: IndexPath){
        let alert = UIAlertController(title: "Alert", message:   message , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: title, style: .default) {_ in
            switch title {
            case "Delete" : self.deleteNote(self.displayNotes[indexPath.row])
                
            case "Add" : self.addToFavorite(indexPath)
                
            default:
                print("Default")
            }
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        view.present(alert, animated: true, completion: nil)
    }
    
    func deleteNote(_ note: AllNotesDataModel) {
        if let index = paginationNotes.firstIndex(where: { $0 === note }) {
            paginationNotes.remove(at: index)
            tblAllNotes.deleteRows(at: [IndexPath(row: index, section: 0)], with: .right)
        }
        DatabaseHelper.shared.deleteNote(note: note)
    }
    
    func addToFavorite(_ indexPath: IndexPath) {
        // favoriteNotes.append(totalNotes[indexPath.row])
    }
    
    @objc func loadData() {
        //    tblAllNotes.reloadRows(at: [indexpath], with: .automatic)
        tblAllNotes.reloadData()
    }
}


//MARK: - UITableViewDataSource
extension AllNotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return paginationNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        self.indexPath = indexPath
        guard let cell = tblAllNotes.dequeueReusableCell(withIdentifier: "allNotesCell", for: indexPath) as? AllNotesTableViewCell else {
            return UITableViewCell()
        }
        cell.configCell(paginationNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        indexpath = indexPath
        if index <= displayNotes.count {
            if indexPath.row == paginationNotes.count - 1 {
                if paginationNotes.count < displayNotes.count {
                    var index = paginationNotes.count
                    limit = index + pageLimit
                    while index < limit && index < displayNotes.count {
                        paginationNotes.append(displayNotes[index])
                        index += 1
                    }
                    self.perform(#selector(loadData), with: nil, afterDelay: 1.0)
                }
            }
        }
    }
}


//MARK: - UITableViewDelegate
extension AllNotesViewController: UITableViewDelegate {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tblAllNotes.setEditing(editing, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action,view,completion) in
            self.showAlert("Delete","Are you sure you want to delete this note?", self,indexPath: indexPath)
            completion(true)
            
        }
        deleteAction.image = R.image.deleteIcon()
        deleteAction.backgroundColor = R.color.deleteBackgroundColor()
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "") { (action,view,completion) in
            self.showAlert("Add","Are you sure you want to add this to your favorites?",self,indexPath: indexPath)
            completion(true)
            
        }
        favAction.image = R.image.favoriteIcon()
        favAction.backgroundColor = R.color.favoriteBackgroundColor()
        return UISwipeActionsConfiguration(actions: [favAction])
    }
    
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == UITableViewCell.EditingStyle.delete) {
//            displayNotes.remove(at: indexPath.row)
//
//        }
//    }
}

//MARK: - UISegmentedControl
extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.cornflower()], for: .selected)
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 5
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 3
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = R.color.cornflower()
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

//MARK: - UIImage
extension UIImage{
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}



//MARK: - PanModalPresentable
extension AllNotesViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(360)
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
}

//extension AllNotesViewController {
//    enum BottomSheet: Int,CaseIterable {
//        case basic
//        case fullScreen
//    }
//
//    var presentable: Presentable {
//        switch self {
//        case .basic: return Basic()
//        case .fullScreen: return FullScreen()
//
//        }
//    }
//
//    struct Basic: Presentable {
//        var type: UIViewController & PanModalPresentable = AddNoteViewController() as! PanModalPresentable
//    }
//
//    struct FullScreen: Presentable {
//        var type: UIViewController & PanModalPresentable = AddNoteViewController() as! PanModalPresentable
//    }
//}
