//
//  ViewController.swift
//  Test
//
//  Created by Mykola Buhaiov on 15.02.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeText(_ sender: UIButton) {
        myLabel.text = "Hello"
    }
    

}

