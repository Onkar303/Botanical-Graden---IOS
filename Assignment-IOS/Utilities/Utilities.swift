//
//  Utilities.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit


class Utilities{
    
    
    static func customAlertController(title:String,message:String) -> UIAlertController
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
        return alertController
    }
    
    
    static func callTerfeleForPlants(url:String?){
        
        guard let url = url else {return}
        
        if let url = URL(string: url)
        {
            URLSession.shared.dataTask(with:url) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                guard let data = data else {return}
                do{
                    let response = try jsonDecoder.decode(Plants.self, from: data)
                } catch {
                    
                }

            }.resume()
        }
        
    }
    
    
    
    
}
