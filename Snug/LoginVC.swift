//
//  LoginVC.swift
//  Snug
//
//  Created by Arman Ansari on 14/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import KeychainSwift



class loginVC: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad () {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func SignIn(_ sender: Any){
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    UserDefaults.standard.set(user!.uid, forKey: "uid")
                    self.performSegue(withIdentifier: "SignIn", sender: nil)
                } else {
                    if error != nil {
                        print ("Can not sign in")
                    }
                }
                }
            }
        }
        
    }
