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
    var list = [String]()
    
    
    let ADD_PLANT_SECTION = 0
    let PLANT_LIST_SECTION = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addTapGesture(view: exhibitionImageView)
        //attactDelegates()
        //configureImage()
        
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
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
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
        if section == PLANT_LIST_SECTION{
            return list.count
        }
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == ADD_PLANT_SECTION {
            let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
            newCell.contentView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            return newCell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
            cell.contentView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == ADD_PLANT_SECTION{
            segueToAddPlantsViewController()
        }else{
            print(indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == ADD_PLANT_SECTION{
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: 100, height: 100)
    }

}

extension CreateExibitionViewController:AddPlantDelegate{
    func addPlantForSelection() {
        
        list.append("dfs")
        collectionViewController.reloadData()
        
    }
    
    
    
    
}
