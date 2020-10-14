//
//  ViewController.swift
//  proiectLFA
//
//  Created by Alex Dobrin on 12/10/2020.
//  Copyright © 2020 NEST Software Co. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class ViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var emailsButton: UIButton!
    @IBOutlet weak var numbersButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    // Creating a reference to the Firebase database
    let ref: DatabaseReference! = Database.database().reference()
    
    private var webView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration())
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBAction func loadPressed(_ sender: Any) {
        let url = URL(string: urlField.text ?? "https://www.google.com/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("Data was nil.")
                return
            }
            guard let htmlString = String(data: data, encoding: String.Encoding.ascii) else {
                print("Cannot cast data into string.")
                return
            }
            print(htmlString)
            let emailPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,3}"
            let phoneNumberPattern = "(40).?[0-9]{3}.?[0-9]{3}.?[0-9]{3}"
            let emails: [String] = self.matches(for: emailPattern, in: htmlString)
            let phoneNumbers: [String] = self.matches(for: phoneNumberPattern, in: htmlString)
            print(emails)
            print(phoneNumbers)
            self.ref.child("Emails").setValue(emails)
            self.ref.child("Phone numbers").setValue(phoneNumbers)
        }
        task.resume()
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    @IBAction func emailsPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEmails", sender: self)
    }
    
    
    @IBAction func numbersPressed(_ sender: Any) {
        performSegue(withIdentifier: "toNumbers", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Settings to make the corners round
        emailsButton.layer.cornerRadius = 15.0
        numbersButton.layer.cornerRadius = 15.0
        loadButton.layer.cornerRadius = 7.5
        // Adding webview and setting its anchors
        webView.uiDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
    }


}

