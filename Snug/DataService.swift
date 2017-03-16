//
//  DataService.swift
//  Snug
//
//  Created by Arman Ansari on 14/03/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift



let DB_BASE = FIRDatabase.database().reference()

class DataService {
    private var _keyChain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var keyChain: KeychainSwift {
        get { 
            return _keyChain
        
        } set {
            _keyChain = newValue
                }
            }
        }
