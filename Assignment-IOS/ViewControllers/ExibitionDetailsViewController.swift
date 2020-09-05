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
    
    
    var exibitionAnnotation:MKAnnotation?
    var exibitionName:String?
    var exibitionDescription:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addFocus()
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
}
