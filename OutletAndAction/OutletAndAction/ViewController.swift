//
//  ViewController.swift
//  OutletAndAction
//
//  Created by Mykola Buhaiov on 23.02.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func changeTextLabel(_ sender: UIButton) {
    label.text = "Hello, World!"
    }
           @IBAction func sayInConsole(_ sender: UIButton) {
            print( "Hello, World in the console!")
            
        }
        
        
        //print(label.text!)
    }
    


