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
    
    let networkingService = NetworkingService()
    
   

    
    @IBAction func SignUp(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print ("Can Not Sign In")
                } else {
                    self.dismiss(animated: true, completion: nil)
                    print(user?.uid)
                }
                
            }
        }
        
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8  )
        
        networkingService.signUp(email: emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, data: data as NSData!)
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
    

   
   



