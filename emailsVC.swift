//
//  emailsVC.swift
//  proiectLFA
//
//  Created by Alex Dobrin on 12/10/2020.
//  Copyright © 2020 NEST Software Co. All rights reserved.
//

import UIKit
import Firebase

class emailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let ref: DatabaseReference! = Database.database().reference()
    let cellReuseIdentifier = "cell"
    var emails: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        ref.child("Emails").observeSingleEvent(of: .value, with: { (snapshot) in
        print("Print #1 \(snapshot)")
            print("Print #2 \(snapshot.value!)")
        if let values = snapshot.value as? [String] {
            self.emails = values
            self.tableView.reloadData()
            print("Print #3\(self.emails)")
        }
        }) { (error) in
        print(error.localizedDescription)
        }
       
    }
}

extension emailsVC: UITableViewDelegate, UITableViewDataSource {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emails.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        // set the text from the data model
        cell.textLabel?.text = self.emails[indexPath.row]
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
}
