//
//  StatsMiddleware.swift
//  SimpleRouter
//
//  Created by Wen Zhao on 3/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SimpleRouter

class StatsMiddleware: Middleware {
    
    func handle(request: RouteRequest, closure: MiddlewareClosure) -> RouteRequest {
        print("Before StatsMiddleware......")
        let returnedRequest = closure(request)
        print("Recording stats......")
        return returnedRequest
    }
}