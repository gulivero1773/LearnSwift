//
//  MenuViewController.swift
//  GoldDiggerHandbook
//
//  Created by Sergey Dunaev on 15/03/2019.
//  Copyright © 2019 SwiftLab. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
