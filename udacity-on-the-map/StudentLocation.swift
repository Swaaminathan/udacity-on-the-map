//
//  Location.swift
//  udacity-on-the-map
//
//  Created by Ra Ra Ra on 6/1/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import Foundation

class StudentLocation {
    
    static var locations: [StudentInformation] = []
    static var errors: [NSError] = []
   
    /**
    Gets the list of recently posted study locations
    */
    class func getRecent() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                self.errors.append(error)
                return
            }
            StudentLocation.parseLocationData(data)
        }
        task.resume()
    }
    
    class func parseLocationData(data: NSData) {
        if let locationData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary {
            if let data = locationData["results"] as? [NSDictionary] {
                for studentInfo in data {
                    locations.append(StudentInformation(data: studentInfo))
                }
            }
        }
    }
    
}