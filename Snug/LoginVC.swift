//
//  LoginVC.swift
//  Snug
//
//  Created by Arman Ansari on 14/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class loginVC: UIViewController {
    
    @IBOutlet weak var background: UIView!
    let gradient = gradients()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = self.view.frame
        background.layer.addSublayer(gradient)
        
    }

}
