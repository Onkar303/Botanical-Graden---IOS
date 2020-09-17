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
    @IBOutlet weak var circularButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        configureUI()
        circularButton.chnageToCustomButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        melbourne.subtitle = "If you're visiting this page, you're likely here because you're searching for a random sentence. Sometimes a random word just isn't enough, and that is where the random sentence generator comes into play. By inputting the desired number, you can make a list of as many random sentences as you want or need. Producing random sentences can be helpful in a number of different ways."
        melbourne.coordinate = CLLocationCoordinate2D(latitude:37.8136, longitude: 144.9631)
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
        
        exibitionDetailsController.exibition = nil
        
        self.navigationController?.pushViewController(exibitionDetailsController, animated: true)
    }
    
}


//MARK:- MAPVIEW DELEGATE
extension HomeViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        segueExhibitionViewController(annotationView: view)
    }
}


func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
    annotationView.image = UIImage(named: "Image")
    return annotationView
}




extension HomeViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {return}
        
        if !setFocus {
            gardenMapView.setRegion(MKCoordinateRegion(center:coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
            setFocus = true
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAutorization()
        
    }
    
}


extension HomeViewController:FocusDelegate{
    func focusOnLocation(annotation: MKPointAnnotation) {
        gardenMapView.addAnnotation(annotation)
        gardenMapView.setRegion(MKCoordinateRegion(center:annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
    }
}

extension HomeViewController{
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}


