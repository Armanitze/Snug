//
//  User.swift
//  Snug
//
//  Created by Arman Ansari on 17/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    var username: String!
    var email: String!
    var key : String!
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? [String: Any]
        
        username = snapshotValue!["username"] as! String
        email = snapshotValue!["email"] as! String
        key = snapshot.key
    }
    
}
