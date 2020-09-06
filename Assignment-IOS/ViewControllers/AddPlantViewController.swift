//
//  AddPlantViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

class AddPlantViewController:UIViewController{
    
    @IBOutlet weak var plantTableView: UITableView!
    var addPlantDelegate : AddPlantDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        attachDelegates()
    }
    
    
    func configureUI()
    {
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func attachDelegates(){
        
        plantTableView.delegate = self
        plantTableView.dataSource = self
    }
    
    
}


extension AddPlantViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AddPlantTableCell.cellIdentifier, for: indexPath) as! AddPlantTableCell
        cell.textLabel?.text = "this is plant"
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPlantDelegate?.addPlantForSelection()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


