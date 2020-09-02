//
//  HomeViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class HomeViewController:UIViewController{
    
    @IBOutlet weak var gardenMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        checkAutorization()
    }
    
    
    func checkAutorization(){
    
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            configureMaps()
            break
        case .authorizedWhenInUse:
            configureMaps()
            showFocusedLocation()
            addAnnotation()
            break
        case .denied:
            break;
        case .notDetermined:
            break;
        case .restricted:
            break;
        default:
            break
        }
    }
    
    
    func configureMaps(){
        gardenMapView.showsUserLocation = true
        gardenMapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func addAnnotation(){
        
        let london = MKPointAnnotation()
        london.title = "London"
        london.subtitle = "This is sparta !1"
        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
        gardenMapView.addAnnotation(london)
        
        
        let brighton = MKPointAnnotation()
        brighton.title = "Brighton"
        brighton.subtitle = "This is brighton"
        brighton.coordinate = CLLocationCoordinate2D(latitude: 50.8225, longitude: 0.1372)
        gardenMapView.addAnnotation(brighton)
    }
    
    
    func showFocusedLocation(){
        guard let location = locationManager.location?.coordinate else {return}
        let coordinates = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        gardenMapView.setRegion(region, animated: true)
        
    }
    
    
    func addBottomSheet(){
        let bottomSheet = PlantDetailsViewController()
        self.addChild(bottomSheet)
        self.view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)

        let height = view.frame.height
        let width  = view.frame.width
        bottomSheet.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    
}


extension HomeViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        present(Utilities.customAlertController(title: "Clicked", message: "yes"),animated: true)
    }
    
   
}




//MARK:- Life Cycle Methods
extension HomeViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addBottomSheet()
        
    }
    
}
