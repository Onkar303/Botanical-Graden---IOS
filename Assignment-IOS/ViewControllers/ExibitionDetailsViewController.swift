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
    
    
    var exibitionAnnotation:MKAnnotation?
    var exibitionName:String?
    var exibitionDescription:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addFocus()
        //configureUI()
        
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
        
        exibitionMapView.layer.cornerRadius = 20.0
        exibitionMapView.layer.shadowColor = UIColor.gray.cgColor
        exibitionMapView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        exibitionMapView.layer.shadowRadius = 12.0
        exibitionMapView.layer.shadowOpacity = 0.7
        
        exibitionImageView.layer.cornerRadius = 20.0
        exibitionImageView.layer.shadowColor = UIColor.gray.cgColor
        exibitionImageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        exibitionImageView.layer.shadowRadius = 12.0
        exibitionImageView.layer.shadowOpacity = 0.7
    }
    
    
}

extension ExibitionDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
