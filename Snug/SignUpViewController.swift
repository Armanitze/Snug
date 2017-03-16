//
//  SignUpViewController.swift
//  Snug
//
//  Created by Arman Ansari on 15/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KeychainSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
   

    
    @IBAction func SignUp(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print ("Can Not Sign In")
                } else {
                    self.performSegue(withIdentifier: "SignUp", sender: nil)
                }
            }
        }
    }

        @IBAction func CancelDidTapped(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    }
    
    
}
    

   
   



