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
    var allExibitions = [Exibition]()
    var setFocus = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        checkAutorization()
    }
    
    //MARK:- CHECK AUTHORIZATION
    func checkAutorization(){
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            configureMaps()
            showFocusedLocation(locationManager: locationManager)
            addAnnotation()
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
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    //MARK:- ADDING ANNOTATIONS
    func addAnnotation(){
        gardenMapView.removeAnnotations(gardenMapView.annotations)
        let databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
        allExibitions = databaseController?.fetchAllExibitions() as! [Exibition]
        allExibitions.forEach { (exibition) in
            let exibitionAnnotation = MKPointAnnotation()
            exibitionAnnotation.title = exibition.exibitionName
            exibitionAnnotation.subtitle = exibition.exibitionDescription
            exibitionAnnotation.coordinate = CLLocationCoordinate2D(latitude:
                exibition.latitude, longitude: exibition.longitude)
            gardenMapView.addAnnotation(exibitionAnnotation)
        }
        
        gardenMapView.showAnnotations(gardenMapView.annotations, animated: true)
    }
    
    //MARK:- INITIAL FOCUS
    func showFocusedLocation(locationManager:CLLocationManager){
        //guard let location = locationManager.location?.coordinate else {return}
        let coordinates = CLLocationCoordinate2D(latitude: Constants.BOTANICAL_GARDEN_LATITUDE, longitude:Constants.BOTANICAL_GARDEN_LONGITUDE)
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        gardenMapView.setRegion(region, animated: true)
    }
    
    
    //MARK:- CONFIGURE UI
    func configureUI(){
        self.navigationItem.largeTitleDisplayMode = .automatic
        
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

        exibitionDetailsController.exibition = retriveExibition(coordinate: annotation.coordinate)
    
        self.navigationController?.pushViewController(exibitionDetailsController, animated: true)
    }
    
    @IBAction func showUserLocation(_ sender: UIBarButtonItem) {
        gardenMapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    func retriveExibition(coordinate:CLLocationCoordinate2D) -> Exibition? {
        var searchedExibition:Exibition?
        allExibitions.forEach { (exibition) in
            if exibition.latitude == coordinate.latitude && exibition.longitude == coordinate.longitude {
                searchedExibition = exibition
            }
        }
        return searchedExibition
    }
    
}


//MARK:- MAPVIEW DELEGATE
extension HomeViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        segueExhibitionViewController(annotationView: view)
    }
}


func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
    let annotationIdentifier = "AnnotationIdentifier"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }

        annotationView!.image = UIImage(named: "Image")

        return annotationView
}




extension HomeViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {return}
            gardenMapView.setRegion(MKCoordinateRegion(center:coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
            locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
    }
}

extension HomeViewController:FocusDelegate{
    func focusOnLocation(annotation: MKPointAnnotation) {
        gardenMapView.addAnnotation(annotation)
        gardenMapView.setRegion(MKCoordinateRegion(center:annotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000), animated: true)
    }
}

extension HomeViewController{
}


