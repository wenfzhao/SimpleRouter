//
//  ViewController.swift
//  SimpleRouter
//
//  Created by Wen Zhao on 03/02/2016.
//  Copyright (c) 2016 Wen Zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButtonClicked(sender: AnyObject) {
        Router.sharedInstance.routeURL("/logout")
    }
    
    @IBAction func albumnAButtonClicked(sender: AnyObject) {
        Router.sharedInstance.routeURL("/album/1")
    }
    
    @IBAction func AlbumnBButtonClicked(sender: AnyObject) {
        Router.sharedInstance.routeURL("/album/2")
    }
}

