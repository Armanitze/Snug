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
    
   
    
    
    let sessionRef = FIRDatabase.database().reference().child("sessions")
    let loctionManager = CLLocationManager()
    let gradient = gradients()
    var uuid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        map.isUserInteractionEnabled = false
        
        if let uuid = UserDefaults.standard.value(forKey: "uuid") as? String {
            self.uuid = uuid
        } else {
            self.uuid = String.randomString(length: 32)
            UserDefaults.standard.set(uuid, forKey: "uuid")
        }
        
        loctionManager.requestAlwaysAuthorization()
        loctionManager.delegate = self
        loctionManager.startUpdatingLocation()
        
        
        let userRef = sessionRef.child("scN82whVK1pQSUMiaa1C7ThTbKQCefta")
        
        userRef.observe(.value, with: { [unowned self] snapshot in
            let snapshotValue = snapshot.value as! [String: AnyObject]
            let lat = snapshotValue["lat"] as! Double
            let lng = snapshotValue["lng"] as! Double
            
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.setMapRegion(for: coord, animated: true)
            
            self.latLabel.text = "\(lat)"
            self.lngLabel.text = "\(lng)"
            
        })
    }
    
    func setMapRegion(for location: CLLocationCoordinate2D, animated: Bool) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 500, 500)
        map.setRegion(viewRegion, animated: animated)
    }


    
    func userUpdated(location: CLLocation) {
        let newSession = sessionRef.child(uuid)
        let info = [
            "lat": location.coordinate.latitude,
            "lng": location.coordinate.longitude
        ]
        newSession.setValue(info)
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        print(locations)
        userUpdated(location: userLocation)
        
    }
    
}



