//
//  ViewController.swift
//  PassDataProject
//
//  Created by Mykola Buhaiov on 23.02.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordsTextField: UITextField!
    
    
    @IBAction func sendPressed(button: UIButton){
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender send: Any?) {
        
        guard let dvc = segue.destination as? SecondViewController else {return}
        dvc.login = loginTextField.text
        
        
    }
}

