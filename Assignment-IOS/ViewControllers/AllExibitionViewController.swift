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
    var filteredExibitions = [Exibition]()
    var isAscending = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
        attachDelegates()
        attachSearchController()
        retriveData()
        
    }
    
    @IBAction func sortList(_ sender: Any) {
        sortExibitions()
    }
    //MARK: - Attaching Delegates
    func attachDelegates(){
        allExibitionTableView.delegate = self
        allExibitionTableView.dataSource = self
        
    }
    
    
    //MARK: - Attach Search Controller
    func attachSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
  
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func configureUI(){
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    //MARK:- Retrive data from database
    func retriveData(){
        allExibitions = databaseController?.fetchAllExibitions() as! [Exibition]
        filteredExibitions.append(contentsOf:allExibitions)
    }
    
    
    //MARK:-Filtering data
    func filterExibitions(searchString:String)
    {
        
        filteredExibitions = allExibitions.filter({ (exibition) -> Bool in
            return (exibition.exibitionName?.lowercased().contains(searchString.lowercased()))!
        })
        allExibitionTableView.reloadData()
    }
    
    //MARK:- SORT in Ascending and Descending order
    func sortExibitions(){
        
        if !isAscending {
            filteredExibitions.sort { (exibitionOne, exibitionTwo) -> Bool in
                     guard let exibitionNameOne = exibitionOne.exibitionName else {return false}
                     guard let exibitionNameTwo = exibitionTwo.exibitionName else {return false}
                     return exibitionNameOne > exibitionNameTwo
                 }
            isAscending = true
        }else{
            filteredExibitions.sort { (exibitionOne, exibitionTwo) -> Bool in
                                guard let exibitionNameOne = exibitionOne.exibitionName else {return false}
                                guard let exibitionNameTwo = exibitionTwo.exibitionName else {return false}
                                return exibitionNameOne < exibitionNameTwo
                            }
            isAscending = false
        }
     
        
        allExibitionTableView.reloadData()
    }
    
    func formatDate(date:Date?) -> String{
        guard let date = date else {return "0/0/0000"}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
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
        return filteredExibitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:AllExibitionTableCell.cellIdentifier, for: indexPath) as! AllExibitionTableCell
        
        let exibition = filteredExibitions[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.exibitionImageView.setRounded()
        if let pngData = exibition.exibitionImage {
            cell.exibitionImageView.image = UIImage(data: pngData)
        }
        cell.exibitionNameLabel.text  = exibition.exibitionName
        cell.exibitionPlantCountLabel.text = "Plants: \(exibition.plant!.count)"
        cell.exibitionCreationDate.text = formatDate(date: exibition.dateOfCreation)
        return cell
    }
    
    //MARK:- CELL CLICK
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let focusDelegate = focusDelegate else {return}
        focusDelegate.focusOnLocation(annotation:getAnnotation(exibition: allExibitions[indexPath.row]))
        navigationController?.popViewController(animated: true)
    }
    
    func getAnnotation(exibition:Exibition)-> MKPointAnnotation{
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude:exibition.latitude, longitude: exibition.longitude)
        pointAnnotation.title = exibition.exibitionName
        pointAnnotation.subtitle = exibition.exibitionDescription
        return pointAnnotation
    }
    
    
    //MARK:- CELL HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(exactly: 100)!
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

//MARK:- SEARCH DELEGATES
extension AllExibitionViewController:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
           filterExibitions(searchString: searchController.searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredExibitions.removeAll()
        filteredExibitions.append(contentsOf: allExibitions)
        allExibitionTableView.reloadData()
    }
}
