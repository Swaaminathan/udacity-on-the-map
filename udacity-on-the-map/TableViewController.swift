//
//  SecondViewController.swift
//  udacity-on-the-map
//
//  Created by Ra Ra Ra on 5/14/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet var pinButtonItem: UIBarButtonItem!
    @IBOutlet var refreshButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButtonItems([refreshButtonItem, pinButtonItem], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

