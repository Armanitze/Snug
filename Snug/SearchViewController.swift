//
//  EmailTableViewController.swift
//  Snug
//
//  Created by Arman Ansari on 29/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SearchViewController: UITableViewController {
    

    var user: FIRUser!
   
    var emails = ["arman"]
    var filteredEmails = [String]()

    var searchController : UISearchController!
    
    let resultsController = UITableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData() 
    }
    
    func fetchData() {
        
        let ref = FIRDatabase.database().reference().child("users")
        
        ref.observe(.value, with: { snapshot in

            UserManager.shared.removeAll()
            for item in snapshot.children {
                guard let snapshot = item as? FIRDataSnapshot else { continue }
                
                let user = User(snapshot: snapshot)
                UserManager.shared.addUsers(user)
                
            }
            
            self.tableView.reloadData()
            
        })
            
    
    }
 

//    func updateSearchResults(for searchController: UISearchController) {
//        
//        // Filter through the emails
//
//        self.filteredEmails = self.emails.filter { (email:String) -> Bool in
//            if email.contains(self.searchController.searchBar.text!){
//                self.tableView.reloadData()
//                return true
//                
//            } else {
//                self.tableView.reloadData()
//                return false
//            }
//        }
//        
//        // Update the results TableView
//        self.resultsController.tableView.reloadData()
//        
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserManager.shared.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let user = UserManager.shared.users[indexPath.row]
        
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.email

        return cell
    }
    

}







