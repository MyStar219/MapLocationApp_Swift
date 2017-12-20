//
//  LocationMapAnnotation.swift
//  MapLocationApp
//
//  Created by Mobile Developer on 12/8/17.
//  Copyright © 2017 Jin Xing. All rights reserved.
//

import UIKit
import MapKit

class LocationMapAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
