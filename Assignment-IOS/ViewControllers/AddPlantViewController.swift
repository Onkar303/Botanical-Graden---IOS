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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        attachDelegates()
    }
    
    
    func configureUI()
    {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Coconut"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.largeTitleDisplayMode = .always
        
        uiActivityIndicator.style = UIActivityIndicatorView.Style.medium
        uiActivityIndicator.center = self.view.center
        uiActivityIndicator.hidesWhenStopped = true
        
        
        self.title = "Plants"
        self.view.addSubview(uiActivityIndicator)
        
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
        return plantDescriptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AddPlantTableCell.cellIdentifier, for: indexPath) as! AddPlantTableCell
        
        let plant = plantDescriptionList[indexPath.row]
        
        cell.plantImageView.layer.cornerRadius = (cell.plantImageView.frame.width)/2
        cell.plantImageView.layer.borderWidth = 2
        cell.plantImageView.layer.borderColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        cell.plantImageView.image = nil
        cell.commanNameLabel.text = plant.commonName
        cell.genusLabel.text = plant.genus
        cell.plantFamilyLabel.text = plant.plantFamily
        cell.scientificNameLabel.text = plant.scientificName
        cell.yearOfDiscoveryLabel.text = "\(String(describing: plant.yearOfDescovery))"
        Utilities.fetchImage(imageView: cell.plantImageView, url: plant.imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(exactly: 350) ?? 350
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPlantDelegate?.addPlantForSelection(data: plantDescriptionList[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
//    func retrivePlantForDatabase(description:PlantDescription) -> Plants{
//        let plant = NSEntityDescription.insertNewObject(forEntityName: "Plants", into: ) as! Plants
//        plant.planFamily = description.plantFamily
//        plant.plantImageURL = description.imageURL
//        plant.plantScientificName = description.scientificName
//        plant.plantYearOfDiscovery = "\(description.yearOfDescovery)"
//        plant.plantName = description.commonName
//        return plant
//    }

}

extension AddPlantViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else {return}
        fetchPlants(searchText: searchQuery)
    }
    
}

extension AddPlantViewController{
    
    func fetchPlants(searchText:String){
        
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

}


