//
//  SignOut.swift
//  Snug
//
//  Created by Arman Ansari on 14/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift


class SignOutCode: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignOut (_ sender : Any){
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        DataService().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
    }
    
        }



    
