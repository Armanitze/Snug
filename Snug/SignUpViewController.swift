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

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
   

    
    @IBAction func SignUp(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
                
                guard let user = user else {
                    print ("Can Not Sign Up")
                    return
                }
                
                self.createUserInDatabase(for: user)
                
            }
        }
        
        //let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8  )
        
    }

    
    func createUserInDatabase(for user: FIRUser) {
        let userRef = FIRDatabase.database().reference().child("users/\(user.uid)")
        
        let newUserInfo: [String: Any] = [
            "email": user.email!,
            "username": usernameTextField.text!,
            "lat": 000,
            "lng": 000
        ]
        
        userRef.setValue(newUserInfo, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error)
            }
        })
    }
    
    
    @IBAction func CancelDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        
        }
        
        alertController.addAction(photoLibraryAction)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        userImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
    

   
   



