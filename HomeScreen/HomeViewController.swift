//
//  HomeViewController.swift
//  DripNote
//
//  Created by Bansi Mamtora on 31/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var btnAddFloating: UIButton!
    
    //MARK: - Variables
    var homeData: [HomeModel] = [ HomeModel(title: "NOTES", detail: "View and edit 64 notes here."),HomeModel(title: "BUCKETS", detail: "View and edit 37 buckets here."),HomeModel(title: "FOLDERS", detail: "View and edit 11 folders here.")]
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let attrs = [
            NSAttributedString.Key.font: R.font.montserratRegular(size: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        btnAddFloating.layer.masksToBounds = true
        btnAddFloating.backgroundColor = R.color.cornflower()
        btnAddFloating.layer.cornerRadius = btnAddFloating.frame.height / 2
        tblHome.backgroundColor = R.color.homeBackground()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        tblHome.backgroundColor = R.color.homeBackground()
    }
    
    //MARK: - Actions
    @IBAction func searchAction(_ sender: Any) {
        
    }
    
}

//MARK: - TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

//MARK: - TableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblHome.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configCell(homeData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row
            == 0 {
            if let allNotes = UIStoryboard(name: "AllNotesScreen", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as? TabViewController {
                navigationController?.pushViewController(allNotes, animated: true)
            }
        } else {
            if let editNote = UIStoryboard(name: "EditNoteScreen", bundle: nil).instantiateViewController(withIdentifier: "EditNoteViewController") as? EditNoteViewController {
                                  //editNote.oldNote = note
                                  self.navigationController?.pushViewController(editNote, animated: true)
                              }
        }
    }
}
