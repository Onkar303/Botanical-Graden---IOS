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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddSearchController()
    }
    
    
    func AddSearchController()
    {
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
        
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
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
