//
//  AllExibitionViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

class AllExibitionViewController:UIViewController{
    
    @IBOutlet weak var allExibitionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachDelegates()
        attachSearchController()
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllExibitionTableCell()
        cell.textLabel?.text = "Cell"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(Utilities.customAlertController(title:"custom", message:"Message"), animated: true, completion: nil)
    }
}
