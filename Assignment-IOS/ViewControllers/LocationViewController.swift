//
//  LocationViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 5/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class LocationViewController:UIViewController{
    
    @IBOutlet weak var locationMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addLongPressToMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        hasAutorization()
        
    }
    
    
    func hasAutorization(){
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            configureLocationManager()
            break
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            break
        default:
            break
        }
    }
    
    
    func configureLocationManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationMapView.showsUserLocation = true
        locationManager.delegate = self
        locationMapView.delegate = self
    }
    
    
    func addLongPressToMap(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addWayPoint(longGesture:)))
        locationMapView.addGestureRecognizer(longPress)
    }
    
    @objc func addWayPoint(longGesture:UIGestureRecognizer){
        
        let touchPoint = longGesture.location(in: locationMapView)
        let wayCoords = locationMapView.convert(touchPoint, toCoordinateFrom: locationMapView)
        let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)

        let wayAnnotation = MKPointAnnotation()
        wayAnnotation.coordinate = wayCoords
        wayAnnotation.title = "waypoint"
        wayAnnotation.coordinate = location.coordinate
        locationMapView.addAnnotation(wayAnnotation)
        
    }
}
extension LocationViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        hasAutorization()
    }
}


extension LocationViewController:MKMapViewDelegate{
    
}
