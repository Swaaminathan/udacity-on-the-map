//
//  StudentInformation.swift
//  udacity-on-the-map
//
//  Created by Russell Austin on 6/10/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import Foundation
import MapKit

class StudentInformation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var firstName: String
    var lastName: String
    var mediaURL: String
    
    var title: String
    var subtitle: String
    
    init(data: NSDictionary) {
        coordinate = CLLocationCoordinate2D(
            latitude: data["latitude"] as! Double!,
            longitude: data["longitude"] as! Double
        )
        firstName = data["firstName"] as! String
        lastName = data["lastName"] as! String
        mediaURL = data["mediaURL"] as! String
        
        title = "\(firstName) \(lastName)"
        subtitle = mediaURL
        
        if let createdAt = data["createdAt"] as? String {
            println(createdAt)
        }
    }
    
    class func isDataValid(data: NSDictionary) -> Bool {
        if let latitude = data["latitude"] as? Double,
            let longitude = data["longitude"] as? Double,
            let firstName = data["firstName"] as? String,
            let lastName = data["lastName"] as? String,
            let mediaURL = data["mediaURL"] as? String
        {
            return true
        }
        return false
    }
}

