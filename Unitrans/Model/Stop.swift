//
//  Line.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import MapKit
import Realm
import RealmSwift

class Stop: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var subTitle: String? = ""
    
    required init(lat: CLLocationDegrees, lon: CLLocationDegrees, title: String) {
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.title = title
        super.init()
    }
}
