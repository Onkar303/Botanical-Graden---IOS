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
    var exibitionName:String?
    var exibitionDescription:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addFocus()
        configureUI()
        attachDelegate()
        
    }
    
    func setData(){
        exibitionNameLabel.text = exibitionName
        exibitionDescriptionLabel.text = exibitionDescription
        exibitionMapView.addAnnotation(exibitionAnnotation!)
    }
    
    func addFocus(){
        guard let coordinate = exibitionAnnotation?.coordinate else {return}
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        exibitionMapView.setRegion(region, animated: true)
    }
    
    func configureUI(){
        //exibitionImageView.setRounded()
        self.title = "Exibition Description"
        exibitionMapView.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        exibitionMapView.isUserInteractionEnabled = false
        
    }
    
    func attachDelegate(){
        sampleCollectionView.delegate = self
        sampleCollectionView.dataSource = self
    }
    
    func segueToPlantDetailsViewController(){
        
        let storyBoard = UIStoryboard(name: "PlantDetailsStoryBoard", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "PlantDetailsViewController") as! PlantDetailsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ExibitionDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantcell", for: indexPath)
        
        cell.contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        cell.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        segueToPlantDetailsViewController()
    }
    
}

