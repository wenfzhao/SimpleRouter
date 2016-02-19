//
//  RouteRequest.swift
//
//  Created by Wen Zhao on 2/19/16.
//

import Foundation

class RouteRequest {
    var url: String
    var parameters: [String: String]?
    var requestData: AnyObject?
    
    init (url: String, parameters: [String: String]?, data: AnyObject?) {
        self.url = url
        
        if let parameters = parameters {
            self.parameters = parameters
        }
        
        if let data = data {
            self.requestData = data
        }
    }
    
    func getParam(name: String) -> String? {
        var param: String?
        if (parameters != nil) {
            param = parameters![name]
        }
        return param;
    }
    
    func setParam(name: String, value: String) {
        parameters = parameters ?? [String: String]()
        parameters![name] = value
    }
    
}
