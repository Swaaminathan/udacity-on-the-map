//
//  SecondViewController.swift
//  udacity-on-the-map
//
//  Created by Ra Ra Ra on 5/14/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit

class TableViewController: LocationViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocationData() {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRefreshLocationData", name: refreshNotificationName, object: nil)
    }
    
    func didRefreshLocationData() {
        tableView.reloadData()
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as! UITableViewCell
        if  StudentLocation.locations.count > indexPath.row {
            let studentInfo = StudentLocation.locations[indexPath.row]
            cell.textLabel!.text = studentInfo.title
            cell.imageView!.image = UIImage(named: "pin")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocation.locations.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if  StudentLocation.locations.count > indexPath.row {
            let studentInfo = StudentLocation.locations[indexPath.row]
            if let url = NSURL(string: studentInfo.mediaURL) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }


}

