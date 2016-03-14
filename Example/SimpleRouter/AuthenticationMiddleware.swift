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
        if (App.isLogin == false) {
            print("User not authenticated")
            var url = "/logout"
            if request.url != "/logout" {
                url = "/logout?_fromUrl=\(request.url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)"
            }
            Router.sharedInstance.routeURL(url)
        } else {
            response = closure(request)
        }
        print("After AuthenticationMiddleware......")
        return response
    }
}
