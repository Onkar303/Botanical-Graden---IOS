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
        exibitionNameLabel.text = exibition?.exibitionName
        exibitionDescriptionLabel.text = exibition?.exibitionDescription
        exibitionMapView.addAnnotation(exibitionAnnotation!)
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
        self.title = "Exibition Description"
        exibitionMapView.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        exibitionMapView.isUserInteractionEnabled = false
        exibitionImageView.setRounded()
        
    }
    
    //MARK:- attaching the delegate
    func attachDelegate(){
        sampleCollectionView.delegate = self
        sampleCollectionView.dataSource = self
    }
    
    //MARK:- performing Segue
    func segueToPlantDetailsViewController(){
        
        let storyBoard = UIStoryboard(name: "PlantDetailsStoryBoard", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "PlantDetailsViewController") as! PlantDetailsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


//MARK:- COLLECTION VIEW DELEGATES
extension ExibitionDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCollectionCell.cellIdentifier, for: indexPath) as! PlantCollectionCell
        
       
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.COLLECTION_CELL_WIDTH, height: Constants.COLLECTION_CELL_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        segueToPlantDetailsViewController()
    }
    
    
}

