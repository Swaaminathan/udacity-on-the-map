//
//  User.swift
//  udacity-on-the-map
//
//  Created by Ra Ra Ra on 5/22/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import Foundation

class User {
    /// username of the logged in user
    static var username = ""
    
    /// key for the logged in user
    static var key = ""
    
    /// session id for the logged in user
    static var sessionId = ""
    
    /**
    Make a login request to the Udacity server
    
    :param: username The username
    :param: password The password
    :param: didComplete The callback function when request competes
    */
    class func logIn(username: String, password: String, didComplete: (success: Bool, errorMessage: String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let bodyString = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                didComplete(success: false, errorMessage: "A network error has occurred.")
                return
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            println(NSString(data: newData, encoding: NSUTF8StringEncoding))
            let success = User.parseUserData(newData)
            let errorMessage: String? = success ? nil : "The email or password was not valid."
            didComplete(success: success, errorMessage: errorMessage)
        }
        task.resume()
    }
    
    class func parseUserData(data: NSData) -> Bool {
        var success = true;
        if let userData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary {
            if let account = userData["account"] as? [String: AnyObject] {
                User.key = account["key"] as! String
            } else {
                success = false
            }
            if let session = userData["session"] as? [String: String] {
                User.sessionId = session["id"]!
            } else {
                success = false
            }
        } else {
            success = false
        }       
        return success;
    }
    
    class func getUser(didComplete: (success: Bool) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/\(User.key)")!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            println(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
}