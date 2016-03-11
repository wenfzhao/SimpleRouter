//
//  AuthenticationMiddleware.swift
//  SimpleRouter
//
//  Created by Wen Zhao on 3/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SimpleRouter

class AuthenticationMiddleware: Middleware {
    
    func handle(request: RouteRequest, closure: MiddlewareClosure) -> RouteRequest {
        var response = request
        print("Authenticating user......")
        let isAuthenticated = false
        if (isAuthenticated == false) {
            print("User not authenticated")
            Router.sharedInstance.routeURL("/logout")
        } else {
            response = closure(request)
        }
        return response
    }
}
