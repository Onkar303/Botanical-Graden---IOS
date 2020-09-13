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
    
    var plantsForExibitionList = [PlantDescription]()
    let ADD_PLANT_SECTION = 0
    let PLANT_LIST_SECTION = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToImage(view: exhibitionImageView)
        addTapGestureForMap(view: exibitionMapView)
        attactDelegates()
        configureImage()
        
    }
    
    @IBAction func addExibition(_ sender: Any) {
    
       let databaseController = (UIApplication.shared.delegate as! AppDelegate).databaseController
        databaseController?.addExibition(data: getExibitionData())
        
    }
    
    func getExibitionData()->ExibitionData{
        
        let exibitionData = ExibitionData()
        exibitionData.exibitionName = exibitionNameTextField.text
        exibitionData.exibitionDescription = exibitiondescriptionTextField.text
        if plantsForExibitionList.count != 0 {
            exibitionData.exibitionPlants = plantsForExibitionList
        }
        exibitionData.exibitionImage = exhibitionImageView.image?.pngData()
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
    
    @objc func pinCoordinates(){
        
        let storyboard = UIStoryboard(name: "LocationStoryBoard", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "LocationViewController") as! LocationViewController
        present(controller, animated: true, completion: nil)
    }
    
    //MARK:- Attach Delegates
    func attactDelegates(){
        collectionViewController.delegate = self
        collectionViewController.dataSource = self
    }
    
    //MARK:- Configure UI
    func configureImage(){
        exhibitionImageView.setRounded()
        exhibitionImageView.frame.size = CGSize(width: 70, height: 70)
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
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
            return addCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCollectionCell
        
        Utilities.fetchImage(imageView:cell.plantImageView, url: plantsForExibitionList[indexPath.row].imageURL)

        cell.layer.cornerRadius = cell.frame.width/2
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
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
        if indexPath.section == ADD_PLANT_SECTION {
            return CGSize(width: 25, height: 25)
        }
        return CGSize(width: 75, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == ADD_PLANT_SECTION {
            return UIEdgeInsets(top: 29.5, left: 0, bottom: 0, right: 10)
        }
        return UIEdgeInsets()
    }
    
}

//MARK:- Adding plant
extension CreateExibitionViewController:AddPlantDelegate{
    
    func addPlantForSelection(data:PlantDescription) {
        plantsForExibitionList.append(data)
        collectionViewController.reloadData()
    }

}
