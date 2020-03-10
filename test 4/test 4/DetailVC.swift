//
//  DetailVC.swift
//  test 4
//
//  Created by Mykola Buhaiov on 26.02.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

var trackTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        Image.image = UIImage(named: trackTitle)
        //Image
        
        titleLabel.text = trackTitle
        titleLabel.numberOfLines = 0
    }
    
}
