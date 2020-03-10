//
//  ViewController.swift
//  test2
//
//  Created by Mykola Buhaiov on 26.02.2020.
//  Copyright © 2020 Mykola Buhaiov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "https://www.aple.com")
        let request = URLRequest(url: url!)
         webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }


}

