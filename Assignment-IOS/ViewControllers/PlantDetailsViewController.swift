//
//  PlantDetailsViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit


class PlantDetailsViewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds

        view.insertSubview(bluredView, at: 0)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
}
