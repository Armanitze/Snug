//
//  NetworkingService.swift
//  Snug
//
//  Created by Arman Ansari on 17/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

struct NetworkingService {
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    private func saveInfo(user: FIRUser!, username:String, password: String) {
        
        let userInfo = ["email": user.email, "username": username, "userId": user.uid, "photoUrl":String(describing: user.photoURL!)]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
    }
    
    //4 --- Signing in the User
    
    func signIn(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error == nil {
                
                if let user = user {
                    
                    
                    print("\(user.displayName) has signed in sucessfully!")
                    
                }
                
                
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
    //2 --- Set User Info
    
    private func setUserInfo(user: FIRUser!, username:String, password: String, data: NSData!) {
        
        
        //Create Path for the user image
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        //Create Image Reference
        
        let imageRef = storageRef.child(imagePath)
        
        //Create Metadata for the image
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //Save the user Image in the Firebase storage file
        
        imageRef.put(data as Data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        
                        self.saveInfo(user: user, username: username, password: password)
                    } else {
                        
                        print(error!.localizedDescription)
                        
                    }
                })
                
            } else {
                
                print(error!.localizedDescription)
            }
            
            
        }
        
        
    }
    
    //1 --- Creating the User
    
    func signUp(email: String, username:String, password: String, data: NSData!) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                self.setUserInfo(user: user, username: username, password: password, data: data)
                
            } else {
                print(error!.localizedDescription)
            }
        })
        
        
        
        
        
    }
    
    func resetPassword(email: String) {
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("An Email with information on how to reset your password has been sent to you, thank you!")
            } else {
                print(error!.localizedDescription)
            }
        })
        
    }
    
}
