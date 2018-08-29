//
//  Line.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class Line: NSObject {
    var lineTitle: String = ""
    var color: UIColor = UIColor()
    var oppositeColor: UIColor = UIColor()
    var stops: [Stop] = [Stop]()
    var isDisplayed: Bool = false
    var path: [[CLLocationCoordinate2D]] = [[CLLocationCoordinate2D]]()
    
    required init(lineTitle: String, color: UIColor, oppositeColor: UIColor, stops: [Stop], path: [[CLLocationCoordinate2D]]) {
        self.lineTitle = lineTitle
        self.color = color
        self.oppositeColor = oppositeColor
        self.stops = stops
        self.path = path
    }

}

