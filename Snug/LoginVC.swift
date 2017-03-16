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
       
        let keyChain = DataService().keyChain

        if keyChain.get ("uid") != nil {
            performSegue(withIdentifier: "SignIn", sender: nil)
        }
        
    }
    
    func CompleteSignIn(id: String){
        let keyChain = DataService().keyChain
        keyChain.set(id, forKey: "uid")
    }
    
    @IBAction func SignIn(_ sender: Any){
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.CompleteSignIn(id: user!.uid)
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
