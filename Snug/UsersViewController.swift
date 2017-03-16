//
//  UsersViewController.swift
//  Snug
//
//  Created by Arman Ansari on 15/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    var uuid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let uuid = UserDefaults.standard.value(forKey: "uuid") as? String {
            self.uuid = uuid
        } else {
            self.uuid = String.randomString(length: 32)
            UserDefaults.standard.set(uuid, forKey: "uuid")
        }
        
    }

    
    
}
