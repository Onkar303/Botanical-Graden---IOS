//
//  ExibitionDetailsViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class ExibitionDetailsViewController:UIViewController{
    
    @IBOutlet weak var exibitionNameLabel: UILabel!
    @IBOutlet weak var exibitionDescriptionLabel: UILabel!
    @IBOutlet weak var exibitionMapView: MKMapView!
    @IBOutlet weak var exibitionImageView: UIImageView!
    @IBOutlet weak var sampleCollectionView: UICollectionView!
    
    var exibitionAnnotation:MKAnnotation?
    var exibitionPlantList = [Plants]()
    var exibition:Exibition?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addFocus()
        configureUI()
        attachDelegate()
        
    }
    
    //MARK:-Setting data
    func setData(){
        self.title = exibition?.exibitionName
        //exibitionNameLabel.text = exibition?.exibitionName
        exibitionDescriptionLabel.text = exibition?.exibitionDescription
        exibitionMapView.addAnnotation(exibitionAnnotation!)
        exibitionImageView.image = UIImage(data: (exibition?.exibitionImage)!)
        exibitionPlantList.append(contentsOf:exibition?.plant?.allObjects as! [Plants])
        
    }
    
    //MARK:- adding focus
    func addFocus(){
        guard let coordinate = exibitionAnnotation?.coordinate else {return}
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(Constants.FOCUS_DISTANCE), longitudinalMeters: CLLocationDistance(Constants.FOCUS_DISTANCE))
        exibitionMapView.setRegion(region, animated: true)
    }
    
    //MARK:- Configureing the ui
    func configureUI(){
        //exibitionImageView.setRounded()
        exibitionMapView.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        exibitionMapView.isUserInteractionEnabled = false
        sampleCollectionView.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        sampleCollectionView.layer.backgroundColor = UIColor(named:"CustomColor")?.cgColor
        
        //exibitionImageView.setRounded()
        
    }
    
    //MARK:- attaching the delegate
    func attachDelegate(){
        sampleCollectionView.delegate = self
        sampleCollectionView.dataSource = self
    }
    
    //MARK:- performing Segue
    func segueToPlantDetailsViewController(plant:Plants){
        let storyBoard = UIStoryboard(name: "PlantDetailsStoryBoard", bundle: .main)
        let plantController = storyBoard.instantiateViewController(identifier: "PlantDetailsViewController") as! PlantDetailsViewController
        plantController.plant = plant
        navigationController?.pushViewController(plantController, animated: true)
    }
}


//MARK:- COLLECTION VIEW DELEGATES
extension ExibitionDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exibitionPlantList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCollectionCell.cellIdentifier, for: indexPath) as! PlantCollectionCell
        cell.plantNameLabel.text = exibitionPlantList[indexPath.row].plantName
        cell.plantImageView.setRounded()
        Utilities.fetchImage(imageView: cell.plantImageView, url: exibitionPlantList[indexPath.row].plantImageURL)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.COLLECTION_CELL_WIDTH, height: Constants.COLLECTION_CELL_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        segueToPlantDetailsViewController(plant: exibitionPlantList[indexPath.row])
    }
}

