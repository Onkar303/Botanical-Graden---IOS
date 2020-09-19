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
    var exibitionName:String?
    var addExibitionDelegate:AddExibitionDelegate?
    var userLocationSet = false
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLongPressToMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        hasAutorization()
        setFocus()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let annotation = locationMapView.annotations.last else {return}
        addExibitionDelegate?.addExibitionPin(exibitionAnnotation: annotation)
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
    
    func setFocus(){
        
        let coordinates = CLLocationCoordinate2D(latitude: Constants.BOTANICAL_GARDEN_LATITUDE, longitude: Constants.BOTANICAL_GARDEN_LONGITUDE)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        locationMapView.setRegion(region, animated: true)
        
    }
    
    
    func addLongPressToMap(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addCoordinate(longGesture:)))
        locationMapView.addGestureRecognizer(longPress)
    }
    
    @objc func addCoordinate(longGesture:UIGestureRecognizer){
        
        locationMapView.removeAnnotations(locationMapView.annotations)
        let touchPoint = longGesture.location(in: locationMapView)
        let wayCoords = locationMapView.convert(touchPoint, toCoordinateFrom: locationMapView)
        let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)

        let exibitionAnnotation = MKPointAnnotation()
        exibitionAnnotation.coordinate = wayCoords
        if title != nil {
           exibitionAnnotation.title = title
        }else {
            exibitionAnnotation.title = "New Exibition"
        }
        
        exibitionAnnotation.coordinate = location.coordinate
        locationMapView.addAnnotation(exibitionAnnotation)
        
    }
}
extension LocationViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        if !userLocationSet {
            let center = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            locationMapView.setRegion(center, animated: true)
            userLocationSet = true
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        hasAutorization()
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
    }
}


extension LocationViewController:MKMapViewDelegate{
    
}
