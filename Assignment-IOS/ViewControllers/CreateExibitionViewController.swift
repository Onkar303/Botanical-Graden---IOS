//
//  CreateExibitionViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CreateExibitionViewController:UIViewController{
    
    @IBOutlet weak var exibitionMapView: MKMapView!
    @IBOutlet weak var exibitiondescriptionTextField: UITextField!
    @IBOutlet weak var exibitionNameTextField: UITextField!
    @IBOutlet weak var exhibitionImageView: UIImageView!
    @IBOutlet weak var collectionViewController: UICollectionView!
    @IBOutlet weak var longitudeTextLabel: UILabel!
    @IBOutlet weak var latitudeTextLabel: UILabel!

    var annotation:MKAnnotation?
    var plantsForExibitionList = [PlantDescription]()
    let ADD_PLANT_SECTION = 0
    let PLANT_LIST_SECTION = 1
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Exibition"
        
        addTapGestureToImage(view: exhibitionImageView)
        addTapGestureForMap(view: exibitionMapView)
        attactDelegates()
        configureImage()
        configureMap()
        
    }
    
    //MARK:- ButtonEvent for adding exibition
    @IBAction func addExibition(_ sender: Any) {
        
        let databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
        databaseController?.addExibition(data: getExibitionData())
        
    }
    
    //MARK:- Fetching data from fields to make exibition
    func getExibitionData()->ExibitionData{
        
        let exibitionData = ExibitionData()
        exibitionData.exibitionName = exibitionNameTextField.text
        exibitionData.exibitionDescription = exibitiondescriptionTextField.text
        exibitionData.exibitionCreationDate = Date()
        
        exibitionData.latitiude = annotation?.coordinate.latitude
        exibitionData.longitude = annotation?.coordinate.longitude
        
        if plantsForExibitionList.count != 0 {
            exibitionData.exibitionPlants = plantsForExibitionList
        }
        if let pngData = exhibitionImageView.image?.pngData() {
            exibitionData.exibitionImage = pngData
        }        
        return exibitionData
    }
    
    //MARK:- Tap gesture for image
    func addTapGestureToImage(view:UIView){
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(addImage))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //MARK:-Tap gesture for Map
    
    func addTapGestureForMap(view:UIView){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pinCoordinates))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
    }
    
    //MARK:- Pin the coordinates
    @objc func pinCoordinates(){
        
        let storyboard = UIStoryboard(name: "LocationStoryBoard", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "LocationViewController") as! LocationViewController
        controller.title = exibitionNameTextField.text
        controller.addExibitionDelegate = self
        present(controller, animated: true, completion: nil)
    }
    
    //MARK:- Attach Delegates
    func attactDelegates(){
        collectionViewController.delegate = self
        collectionViewController.dataSource = self
    }
    
    //MARK:- Configure Image
    func configureImage(){
        exhibitionImageView.setRounded()
        exhibitionImageView.frame.size = CGSize(width: 70, height: 70)
    }
    
    func configureMap(){
        exibitionMapView.layer.cornerRadius = exibitionMapView.layer.frame.width/2
        exibitionMapView.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK:- Perform Segue
    func segueToAddPlantsViewController(){
        let storyBoard = UIStoryboard(name: "AddPlantsStoryBoard", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "AddPlantViewController") as! AddPlantViewController
        controller.addPlantDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

}

//MARK:- UIImagePicker Delegates
extension CreateExibitionViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true, completion: nil)
        exhibitionImageView.image = image
    }
    
}


//MARK:-Collection View Delegates
extension CreateExibitionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == ADD_PLANT_SECTION{
            return 1
        }
        return plantsForExibitionList.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == ADD_PLANT_SECTION {
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as! AddPlantCollectionCell
            return addCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCollectionCell.cellIdentifier, for: indexPath) as! PlantCollectionCell
        
        Utilities.fetchImage(imageView:cell.plantImageView, url: plantsForExibitionList[indexPath.row].imageURL)
        cell.plantImageView.setRounded()
        cell.plantNameLabel.text = plantsForExibitionList[indexPath.row].commonName
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == ADD_PLANT_SECTION{
            segueToAddPlantsViewController()
        }else{
            print(indexPath)
        }
    }
    
    //MARK:- Setting cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == ADD_PLANT_SECTION{
            return CGSize(width: 50, height: 110)
        }
        return CGSize(width: 90, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == ADD_PLANT_SECTION {
            return UIEdgeInsets(top:0, left: 0, bottom: 0, right: 10)
        }
        return UIEdgeInsets()
    }
    
    //MARK:- Adding context menu
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        if indexPath.section == PLANT_LIST_SECTION {
            let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
                     let view = UIAction(title: "View Description"){ (handler) in
                         print("this is view")
                     }
                    view.image = UIImage(systemName: "eye.fill")
                     
                     let delete = UIAction(title: "Delete Plant") { (handler) in
                         print("this is delete")
                     }
                    delete.image = UIImage(systemName: "trash.fill")
                     
                     return UIMenu(title: "Options", image: nil, identifier: nil, options: .displayInline , children: [view,delete])
                 }
              return configuration
        }
        return nil
    }
    
    
}

//MARK:- Adding Exibition
extension CreateExibitionViewController:AddExibitionDelegate{
    func addExibitionPin(exibitionAnnotation: MKAnnotation) {
        annotation = exibitionAnnotation
        exibitionMapView.removeAnnotations(exibitionMapView.annotations)
        exibitionMapView.addAnnotation(exibitionAnnotation)
        exibitionMapView.setRegion(MKCoordinateRegion(center: exibitionAnnotation.coordinate , latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        
        latitudeTextLabel.text = "Lat: \(String(format: "%.2f", exibitionAnnotation.coordinate.latitude))"
        longitudeTextLabel.text = "Long: \(String(format:"%.2f",exibitionAnnotation.coordinate.longitude))"
    }
    
    
}


//MARK:- Adding plant
extension CreateExibitionViewController:AddPlantDelegate{
    func addPlantForSelection(data:PlantDescription) {
        plantsForExibitionList.insert(data, at: 0)
        collectionViewController.reloadData()
    }
    
}
