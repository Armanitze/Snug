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

class EmailTableViewController: UITableViewController, UISearchResultsUpdating {

    var emails = ["Email"]
    var filteredEmails = [String]()
    

    var searchController : UISearchController!
    
    var resultsController = UITableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
      
    }

    func updateSearchResults(for searchController: UISearchController) {
        
        // Filter through the emails
        
        self.filteredEmails = self.emails.filter { (email:String) -> Bool in
            if email.contains(self.searchController.searchBar.text!){
                self.tableView.reloadData()
                return true
                
            } else {
                self.tableView.reloadData()
                return false
            }
        }
        
        // Update the results TableView
        self.resultsController.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
        
        return self.emails.count
        } else {
            return self.filteredEmails.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if tableView == self.tableView{
        
        cell.textLabel?.text = self.emails[indexPath.row]
            
        } else {
            cell.textLabel?.text = self.filteredEmails[indexPath.row]
        }

        return cell
    }
    

    }
