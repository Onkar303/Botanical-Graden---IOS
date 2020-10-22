//
//  CreateExibitionViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

//MARK:- Please note that Collection view cell are configured with context view , do give it a try  and this view controller is used for making new exibitions

import Foundation
import UIKit
import MapKit

class CreateExibitionViewController:UIViewController{
    
    @IBOutlet weak var exibitionMapView: MKMapView!
    @IBOutlet weak var exibitiondescriptionTextField: UITextField!
    @IBOutlet weak var exibitionNameTextField: UITextField!
    @IBOutlet weak var exhibitionImageView: UIImageView!
    @IBOutlet weak var plantCollectionView: UICollectionView!
    //@IBOutlet weak var longitudeTextLabel: UILabel!
    //@IBOutlet weak var latitudeTextLabel: UILabel!
    
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
        configureUI()
        //configureImage()
        //configureMap()
        
    }
    
    //MARK:- ButtonEvent for adding exibition with validations
    @IBAction func addExibition(_ sender: Any) {
        
        let databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
       
        
        
        if exibitionNameTextField.text == "" {
            present(Utilities.customAlertController(title: "Alert!", message: "Exibition Name cannot be empty"), animated: true, completion: nil)
            return
        }
        
        if exibitiondescriptionTextField.text == "" {
            present(  Utilities.customAlertController(title: "Alert!", message: "Exibition description cannot be empty"), animated: true, completion: nil)
            return
            
        }
        
        if exibitionMapView.annotations.count == 0 {
            present(Utilities.customAlertController(title: "Alert!", message: "Please set a location for the exhibition"), animated: true, completion: nil)
            return
        }
        
        if plantsForExibitionList.count < 3 {
            present( Utilities.customAlertController(title: "Alert!", message: "A minimum of 3 plants are required to create an exibition"), animated: true, completion: nil)
            return
        }
        
        databaseController?.addExibition(data: getExibitionData())
        databaseController?.saveContext()
        
        //present(Utilities.customAlertController(title: "Alert!", message: "Saved Successfully"), animated: true, completion: nil)
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func configureUI(){
        
        exibitionMapView.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        plantCollectionView.layer.cornerRadius = CGFloat(Constants.CORNER_RAIUS)
        
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
        plantCollectionView.delegate = self
        plantCollectionView.dataSource = self
        exibitionNameTextField.delegate = self
        exibitiondescriptionTextField.delegate = self

    }
    
    //MARK:- Configure Image
    func configureImage(){
        exhibitionImageView.setRounded()
        exhibitionImageView.frame.size = CGSize(width: 70, height: 70)
    }
    
//    //MARK:- configure maps
//    func configureMap(){
//        exibitionMapView.layer.cornerRadius = exibitionMapView.layer.frame.width/2
//        exibitionMapView.clipsToBounds = true
//    }
    
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
    
    func segueToPlantdetailsViewcontroller(plantDescription:PlantDescription){
        let storyBoard = UIStoryboard(name: "PlantDetailsStoryBoard", bundle: .main)
        let plantController = storyBoard.instantiateViewController(identifier: "PlantDetailsViewController") as! PlantDetailsViewController
        plantController.plantDescription = plantDescription
        self.navigationController?.pushViewController(plantController, animated: true)
        
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
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPlantCollectionCell.cellIdentifier, for: indexPath) as! AddPlantCollectionCell
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
                    self.segueToPlantdetailsViewcontroller(plantDescription: self.plantsForExibitionList[indexPath.row])
                }
                view.image = UIImage(systemName: "eye.fill")
                
                let delete = UIAction(title: "Delete Plant") { (handler) in
                    self.plantsForExibitionList.remove(at: indexPath.row)
                    //self.plantCollectionView.reloadData()
                    self.plantCollectionView.performBatchUpdates({
                        self.plantCollectionView.deleteItems(at: [indexPath])
                    }, completion: nil)
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
        
        //latitudeTextLabel.text = "Lat: \(String(format: "%.2f", exibitionAnnotation.coordinate.latitude))"
        //longitudeTextLabel.text = "Long: \(String(format:"%.2f",exibitionAnnotation.coordinate.longitude))"
    }
}


//MARK:- Adding plant
extension CreateExibitionViewController:AddPlantDelegate{
    func addPlantForSelection(data:PlantDescription) {
        plantsForExibitionList.insert(data, at: 0)
        plantCollectionView.reloadData()
    }
    
}

//MARK:- Textfield delegates
extension CreateExibitionViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        exibitionNameTextField.resignFirstResponder()
        exibitiondescriptionTextField.resignFirstResponder()
        return true
    }
    
}
