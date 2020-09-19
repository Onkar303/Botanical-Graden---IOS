//
//  AddPlantViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddPlantViewController:UIViewController{
    
    @IBOutlet weak var plantTableView: UITableView!
    weak var addPlantDelegate : AddPlantDelegate?
    var plantDescriptionList = [PlantDescription]()
    var uiActivityIndicator = UIActivityIndicatorView()
    var plantDatabaseList = [Plants]()
    var filteredPlantDatabaseList = [Plants]()
    var databaseController:DatabaseController?
    var arePlantsFromDatabase:Bool = true
    
    
    let DATABASE_SECTION = 0
    let API_SECTION = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        attachDelegates()
    }
    
    
    func configureUI()
    {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.scopeButtonTitles = ["Saved","Online"]
        searchController.searchBar.showsScopeBar = true
        searchController.definesPresentationContext =  true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Coconut"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        
        uiActivityIndicator.style = UIActivityIndicatorView.Style.medium
        uiActivityIndicator.center = self.view.center
        uiActivityIndicator.hidesWhenStopped = true
        
        
        self.title = "Plants"
        self.view.addSubview(uiActivityIndicator)
        
        databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationItem.searchController?.becomeFirstResponder()
    }
    
    func attachDelegates(){
        plantTableView.delegate = self
        plantTableView.dataSource = self
    }
    
    func filterListFromDatabase(searchText:String){
        filteredPlantDatabaseList = plantDatabaseList.filter({ (plants) -> Bool in
            return (plants.plantName?.contains(searchText))!
        })
        plantTableView.reloadData()
    }
    
    
}


extension AddPlantViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arePlantsFromDatabase {
            return filteredPlantDatabaseList.count
        }
        return plantDescriptionList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arePlantsFromDatabase {
            let dbCell = tableView.dequeueReusableCell(withIdentifier: AddPlantTableCell.cellIdentifier, for: indexPath) as! AddPlantTableCell
            
            let plant = plantDatabaseList[indexPath.row]
            dbCell.plantImageView.setRounded()
            dbCell.commanNameLabel.text = plant.plantName
            dbCell.plantFamilyLabel.text = plant.plantFamily
            Utilities.fetchImage(imageView: dbCell.plantImageView, url: plant.plantImageURL)
            dbCell.accessoryType = .disclosureIndicator
            return dbCell
            
        }
        let apiCell = tableView.dequeueReusableCell(withIdentifier:AddPlantTableCell.cellIdentifier, for: indexPath) as! AddPlantTableCell
        let plant = plantDescriptionList[indexPath.row]
        
        apiCell.plantImageView.setRounded()
        apiCell.plantImageView.image = nil
        apiCell.commanNameLabel.text = plant.commonName
        //cell.genusLabel.text = plant.genus
        apiCell.plantFamilyLabel.text = plant.plantFamily
        //cell.scientificNameLabel.text = plant.scientificName
        //cell.yearOfDiscoveryLabel.text = "\(String(describing: plant.yearOfDescovery))"
        apiCell.accessoryType = .disclosureIndicator
        Utilities.fetchImage(imageView: apiCell.plantImageView, url: plant.imageURL)
        return apiCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(exactly: 100 ) ?? 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arePlantsFromDatabase {
            addPlantDelegate?.addPlantForSelection(data: Utilities.convertFromPlantsToPlantDescription(data: plantDatabaseList[indexPath.row]))
        } else {
            addPlantDelegate?.addPlantForSelection(data: plantDescriptionList[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if arePlantsFromDatabase {
            return "Saved"
        }
        return "Search"
        
    }
}

extension AddPlantViewController:UISearchBarDelegate,UISearchResultsUpdating{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if arePlantsFromDatabase {
            return
        }
        guard let searchQuery = searchBar.text else {return}
        fetchPlants(searchText: searchQuery)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if arePlantsFromDatabase && searchController.searchBar.text == "" {
            filteredPlantDatabaseList.removeAll()
            filteredPlantDatabaseList.append(contentsOf:plantDatabaseList)
            plantTableView.reloadData()
        }

        if arePlantsFromDatabase && searchController.searchBar.text != "" {
            filterListFromDatabase(searchText: searchController.searchBar.text!)
            return
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0{
            arePlantsFromDatabase = true
            plantTableView.reloadData()
        }else {
            arePlantsFromDatabase = false
            plantTableView.reloadData()
        }
    }
    
}

extension AddPlantViewController{
    
    func fetchPlants(searchText:String){
        plantDescriptionList.removeAll()
        uiActivityIndicator.startAnimating()
        URLSession.shared.dataTask(with: URL(string:Constants.BASE_URL + Constants.SEARCH_PARAM + Constants.TOKEN_PARAM + Constants.TOKEN + "&q=" + searchText)!) { (data, response, error) in
            
            if error != nil{
                fatalError("there was an error fetching data \(String(describing: error))")
            }
            
            do{
                let decoder = JSONDecoder()
                let plantData = try decoder.decode(PlantData.self, from: data!)
                guard let data = plantData.data else {return}
                self.plantDescriptionList.append(contentsOf:data)
                DispatchQueue.main.async {
                    self.uiActivityIndicator.stopAnimating()
                    self.plantTableView.reloadData()
                }
            } catch{
                fatalError("error in fetching data")
            }
        }.resume()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let list = databaseController?.fecthAALPlants() else {return}
        plantDatabaseList = list
        filteredPlantDatabaseList.append(contentsOf: plantDatabaseList)
    }
    
}


