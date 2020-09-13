//
//  CreateExibitionViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

class CreateExibitionViewController:UIViewController{
    
    @IBOutlet weak var exhibitionImageView: UIImageView!
    @IBOutlet weak var collectionViewController: UICollectionView!
    var plantsForExibitionList = [Plants]()
    
   
    
    let ADD_PLANT_SECTION = 0
    let PLANT_LIST_SECTION = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture(view: exhibitionImageView)
        attactDelegates()
        configureImage()
        
    }
    
    func addTapGesture(view:UIView){
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
    
    func attactDelegates(){
        collectionViewController.delegate = self
        collectionViewController.dataSource = self
    }
    
    func configureImage(){
        exhibitionImageView.setRounded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func segueToAddPlantsViewController(){
        let storyBoard = UIStoryboard(name: "AddPlantsStoryBoard", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "AddPlantViewController") as! AddPlantViewController
        controller.addPlantDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension CreateExibitionViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true, completion: nil)
        exhibitionImageView.image = image
    }
    
}

extension CreateExibitionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == ADD_PLANT_SECTION{
            return 1
        }
        return 10
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == ADD_PLANT_SECTION {
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath)
        
            return addCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCollectionViewCell
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == ADD_PLANT_SECTION {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        return UIEdgeInsets()
    }
    
}

extension CreateExibitionViewController:AddPlantDelegate{
    
    func addPlantForSelection(data: PlantDescription) {
           
           collectionViewController.reloadData()
    }

}
