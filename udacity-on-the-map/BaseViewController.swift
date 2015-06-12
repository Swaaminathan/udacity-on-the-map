//
//  BaseViewController.swift
//  udacity-on-the-map
//
//  Created by Russell Austin on 6/11/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit
import MapKit

/// Share between all controllers
class BaseViewController: UIViewController {

   
    internal func showErrorAlert(title: String, defaultMessage: String, errors: [NSError]) {
        var message = defaultMessage
        if !errors.isEmpty {
            message = errors[0].localizedDescription
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OkAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OkAction)
        self.presentViewController(alertController, animated: true, completion: nil)       
    }
}