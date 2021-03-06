//
//  ViewController.swift
//  Snug
//
//  Created by Arman Ansari on 15/02/2017.
//  Copyright © 2017 Arman Ansari. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

class ViewController: UIViewController {
   

    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var active: UILabel!
   
    
    var userRef: FIRDatabaseReference!
    var watchUser: User!
    var watchingRef: FIRDatabaseReference?
    
    let loctionManager = CLLocationManager()
    var uid: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loctionManager.requestAlwaysAuthorization()
        loctionManager.delegate = self
        loctionManager.startUpdatingLocation()
        
        print(UserManager.shared.users)
        
        map.isUserInteractionEnabled = false
        
        uid = UserDefaults.standard.string(forKey: "uid")!
        
        userRef = FIRDatabase.database().reference().child("users/\(uid!)")
        
        startWatching()
        
    }

    
    func startWatching() {
        
        watchingRef = FIRDatabase.database().reference().child("users/\(watchUser.key!)")
        
        watchingRef!.observe(.value, with: { [unowned self] snapshot in
            let snapshotValue = snapshot.value as! [String: AnyObject]
            let lat = snapshotValue["lat"] as! Double
            let lng = snapshotValue["lng"] as! Double
            
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.setMapRegion(for: coord, animated: true)
            
            self.latLabel.text = "\(lat)"
            self.lngLabel.text = "\(lng)"
        })
        
    }
    
    
    
    

    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            
            let info = [
                "impact": true
               
                
            ]
            self.active.text = "SOS"
            
            userRef.updateChildValues(info)
            
            
            
        }
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            
            let controller = UIAlertController(title: "Warning", message: "This user had an accident", preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(controller, animated: true, completion: nil)
            
        }
        
    }
    
 

    
    func setMapRegion(for location: CLLocationCoordinate2D, animated: Bool) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 200, 200)
        map.setRegion(viewRegion, animated: animated)
    }


    
    func userUpdated(location: CLLocation) {
        let info = [
            "lat": location.coordinate.latitude,
            "lng": location.coordinate.longitude
        ]
        userRef.updateChildValues(info)
    }
    
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        userUpdated(location: userLocation)
    }
    
}



