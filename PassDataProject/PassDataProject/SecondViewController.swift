//
//  SecondViewController.swift
//  PassDataProject
//
//  Created by Mykola Buhaiov on 23.02.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var login: String!
        @IBOutlet weak  var label: UILabel!
        
        
        @IBAction func sendPressed(button: Button) {
            
        }
    
    overide func viewDidLoad(){
        super.viewDidLoad()
        print(login)
        
    }

}
