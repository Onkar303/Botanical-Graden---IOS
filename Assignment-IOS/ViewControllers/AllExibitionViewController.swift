//
//  AllExibitionViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AllExibitionViewController:UIViewController{
    
    @IBOutlet weak var allExibitionTableView: UITableView!
    var focusDelegate : FocusDelegate?
    var databaseController:DatabaseController?
    var allExibitions = [Exibition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
        attachDelegates()
        attachSearchController()
        retriveData()
        
    }
    
    //MARK: - Attaching Delegates
    func attachDelegates(){
        allExibitionTableView.delegate = self
        allExibitionTableView.dataSource = self
        
    }
    
    
    //MARK: - Attach Search Controller
    func attachSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func configureUI(){
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    func retriveData(){
        allExibitions = databaseController?.fetchAllExibitions() as! [Exibition]
    }
    
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        <#code#>
    //    }
    
}


//MARK: - TableView Delegate Methods
extension AllExibitionViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allExibitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AllExibitionTableCell.cellIdentifier, for: indexPath) as! AllExibitionTableCell
        
        let exibition = allExibitions[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.plantNameLabel.text  = exibition.exibitionName
        cell.plantDescriptionLabel.text = "\(exibition.exibitionDescription) + \(exibition.plant?.count)"
        return cell
    }
    
    //MARK:- CELL CLICK
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let focusDelegate = focusDelegate else {return}
        focusDelegate.focusOnLocation(annotation:MKPointAnnotation())
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- CELL HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(exactly: 200)!
    }
    
    
    //MARK:- DELETE CELL
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            databaseController?.removeExibition(exibition: allExibitions[indexPath.row])
            self.allExibitions.remove(at: indexPath.row)
            tableView.reloadData()
            
            
            
        }
    }
    
    
    
    
    
    
    
    
}
