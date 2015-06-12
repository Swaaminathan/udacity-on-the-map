//
//  LocationViewController.swift
//  udacity-on-the-map
//
//  Created by Russell Austin on 6/12/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit

/// Shared functionality for map and table view
class LocationViewController: BaseViewController {
    
    @IBOutlet var pinButtonItem: UIBarButtonItem!
    @IBOutlet var refreshButtonItem: UIBarButtonItem!
    
    // allows subclass-specific refresh handler
    let refreshNotificationName = "Location Data Refresh Notification"
    
     override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButtonItems([refreshButtonItem, pinButtonItem], animated: false)
    }
    
    @IBAction func didPressRefresh(sender: UIBarButtonItem) {
        self.loadLocationData(forceRefresh: true) {
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: self.refreshNotificationName, object: self))
        }
    }
    
    @IBAction func didPressLogout(sender: UIBarButtonItem) {
        sender.enabled = false
        User.logOut() { success in
            sender.enabled = true
            if !success {
                self.showErrorAlert("Logout Failed", defaultMessage: "Could not log out", errors: User.errors)
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func didPressPin(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showPost", sender: self)
    }
    
    /**
    Loads location data or displays an error message if the data cannot be loaded.
    
    :param: forceRefresh Force the data to be retrieved over the network
    */
    internal func loadLocationData(forceRefresh: Bool = false, didComplete: (() -> Void)?) {
         StudentLocation.getRecent(forceRefresh: forceRefresh) { success in
            if !success {
                self.showErrorAlert("Error Loading Locations", defaultMessage: "Loading failed.", errors: StudentLocation.errors)
            } else if !StudentLocation.locations.isEmpty && didComplete != nil {
                didComplete!()
            }
        }       
    }
    
}
