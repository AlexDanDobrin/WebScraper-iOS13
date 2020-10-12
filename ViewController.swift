//
//  ViewController.swift
//  proiectLFA
//
//  Created by Alex Dobrin on 12/10/2020.
//  Copyright © 2020 NEST Software Co. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    private var webView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration())
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBAction func loadPressed(_ sender: Any) {
        let url = URL(string: urlField.text ?? "https://www.google.com/")
        
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    
    @IBAction func emailsPressed(_ sender: Any) {
    }
    
    
    @IBAction func numbersPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
    }


}

