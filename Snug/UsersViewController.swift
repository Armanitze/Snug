//
//  UsersViewController.swift
//  Snug
//
//  Created by Arman Ansari on 15/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController {
    
    var uuid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uuid = UserDefaults.standard.value(forKey: "uuid") as! String
        print(uuid)
    
        
    }
    @IBAction func SignOut(_ sender: Any) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
        
        dismiss(animated: true, completion: nil)

    }
}
