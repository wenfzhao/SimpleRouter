//
//  AppDelegate.swift
//  SimpleRouter
//
//  Created by Wen Zhao on 03/02/2016.
//  Copyright (c) 2016 Wen Zhao. All rights reserved.
//

import UIKit
import SimpleRouter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let router = Router.sharedInstance
        let middlewares: [Middleware] = [
            AuthenticationMiddleware(),
            StatsMiddleware()
        ]
        router.map("/") { (request: RouteRequest) -> RouteRequest in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("rootViewController")
            return request
        }.withMiddlewares(middlewares)
        
        router.map("/logout") { (request: RouteRequest) -> RouteRequest in
            App.isLogin = false
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("logoutViewController") as! LogoutViewController
            if let fromUrl = request.getParam("_fromUrl") {
                viewController.fromUrl = fromUrl
            }
            self.window?.rootViewController = viewController
            return request
        }.withMiddlewares([StatsMiddleware()])
        
        router.map("/album/:albumId") { (request: RouteRequest) -> RouteRequest in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("albumViewController") as! AlbumViewController
            viewController.albumId = Int(request.getParam("albumId")!)
//            self.window?.rootViewController?.presentViewController(viewController, animated: false, completion: nil)
            let rootViewController = self.window?.rootViewController as! UINavigationController
            rootViewController.pushViewController(viewController, animated: false)
            return request
        }.withMiddlewares(middlewares)
        
        router.routeURL("/")
        // Override point for customization after application launch.
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let absoluteUrl = url.absoluteString
        // change mm-ignites://c/1/2 to /c/1/2 for internal routing
        let route = absoluteUrl.stringByReplacingOccurrencesOfString("\(url.scheme as String)://", withString: "/")
        Router.sharedInstance.routeURL(route)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

