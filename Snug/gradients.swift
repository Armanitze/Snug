import Foundation
import UIKit

class gradients: CAGradientLayer {
    
    
    override func layoutSublayers() {
        
        let gradient = gradients()
        gradient.colors = [UIColor(red: 136/255.5 , green: 196/255.5 , blue: 255/255.5 , alpha: 1.0).cgColor, UIColor(red: 3/255.5 , green: 41/255.5 , blue: 144/255.5 , alpha: 1.0).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        
    }
}


