//
//  LogoutViewController.swift
//  SimpleRouter
//
//  Created by Wen Zhao on 3/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var fromUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(sender: AnyObject) {
        App.isLogin = true
        Router.sharedInstance.routeURL("/")
        if fromUrl != nil {
            Router.sharedInstance.routeURL(fromUrl!)
        }
    }
}
