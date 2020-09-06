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
        configureUI()
    }
    
    //MARK:- CHECK AUTHORIZATION
    func checkAutorization(){
    
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            configureMaps()
            break
        case .authorizedWhenInUse:
            configureMaps()
            showFocusedLocation(locationManager: locationManager)
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
    
    //MARK:- CONFIGURE MAPS
    func configureMaps(){
        gardenMapView.showsUserLocation = true
        gardenMapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    //MARK:- ADDING ANNOTATIONS
    func addAnnotation(){
        
        let london = MKPointAnnotation()
        london.title = "London"
        london.subtitle = "This is sparta !1"
        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
        gardenMapView.addAnnotation(london)
        
        
        let brighton = MKPointAnnotation()
        brighton.title = "Brighton"
        brighton.subtitle = "This is brighton and this is the best place in the entire country .. I love coming over here !!"
        brighton.coordinate = CLLocationCoordinate2D(latitude: 50.8225, longitude: 0.1372)
        gardenMapView.addAnnotation(brighton)
        
        
        let melbourne = MKPointAnnotation()
        melbourne.title = "Melbourne"
        melbourne.subtitle = "This is Melbourne and this is the best place in the entire country .. I love coming over here !!"
        melbourne.coordinate = CLLocationCoordinate2D(latitude: 144.9631, longitude: 37.8136)
        gardenMapView.addAnnotation(melbourne)
        
    }
    
    //MARK:- INITIAL FOCUS
    func showFocusedLocation(locationManager:CLLocationManager){
        guard let location = locationManager.location?.coordinate else {return}
        let coordinates = CLLocationCoordinate2D(latitude:location.latitude, longitude:location.longitude)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        gardenMapView.setRegion(region, animated: true)
    }
    
    
    //MARK:- CONFIGURE UI
    func configureUI(){
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    //MARK:- PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "allExibitionViewController"
        {
            let allExibitionViewController = segue.destination as! AllExibitionViewController
            allExibitionViewController.focusDelegate = self;
        }
    }
    
    
    //MARK:- SEGUE TO EXIBITION VIEW CONTROLLER
    func segueExhibitionViewController(annotationView:MKAnnotationView){
        let storyboard = UIStoryboard(name: "ExibitionDetailsStoryBoard", bundle: .main)
        let exibitionDetailsController = storyboard.instantiateViewController(withIdentifier: "ExibitionDetailsViewController") as! ExibitionDetailsViewController
      
        guard let annotation = annotationView.annotation else {return}
        exibitionDetailsController.exibitionAnnotation = annotation
        
        guard let exibitionName = annotation.title else {return}
        exibitionDetailsController.exibitionName = exibitionName
        
        guard let exibitionDescription = annotation.subtitle else {return}
        exibitionDetailsController.exibitionDescription = exibitionDescription
        
        self.navigationController?.pushViewController(exibitionDetailsController, animated: true)
    }
    
    
    
}


//MARK:- MAPVIEW DELEGATE
extension HomeViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        segueExhibitionViewController(annotationView: view)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
//        
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
//        } else if let title = annotation.title , title == "Brighton"{
//            annotationView?.image = UIImage(named: "Image")
//        }
//        
//        return annotationView
//      }
//    
   
}

extension HomeViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {return}
        gardenMapView.setRegion(MKCoordinateRegion(center:coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
    }
    
}


extension HomeViewController:FocusDelegate{
    func focusOnLocation() {
        
    }
    
}


