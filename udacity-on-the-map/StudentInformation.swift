//
//  StudentInformation.swift
//  udacity-on-the-map
//
//  Created by Russell Austin on 6/10/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import Foundation
import MapKit

struct StudentInformation {
    var coordinate: CLLocationCoordinate2D!
    var firstName: String!
    var lastName: String!
    var mapString: String!
    var mediaUrl: String!
    var uniqueKey: String!
    
    init(data: NSDictionary) {
        if let latitude = data["latitude"] as? Double,
            let longitude = data["longitude"] as? Double,
            let firstName = data["firstName"] as? String,
            let lastName = data["lastName"] as? String,
            let mapString = data["mapString"] as? String,
            let mediaUrl = data["mediaUrl"] as? String,
            let uniqueKey = data["uniqueKey"] as? String
        {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.firstName = firstName
            self.lastName = lastName
            self.mapString = mapString
            self.mediaUrl = mediaUrl
            self.uniqueKey = uniqueKey
        } else {
            // error
        }
    }
}

