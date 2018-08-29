//
//  Utilities.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension UIViewController {
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}


class MyMKOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    
    var boundingMapRect: MKMapRect
    
    var color: UIColor!
    
    init(coordinate: CLLocationCoordinate2D, boundingMapRect: MKMapRect, color: UIColor) {
        self.coordinate = coordinate
        self.boundingMapRect = boundingMapRect
        self.color = color
    }
}
