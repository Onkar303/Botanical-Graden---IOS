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
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture(view: exhibitionImageView)
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
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    

}

extension CreateExibitionViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true, completion: nil)
        exhibitionImageView.image = image
        
    }
    
}
