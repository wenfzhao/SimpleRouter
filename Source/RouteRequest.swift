//
//  RouteRequest.swift
//
//  Created by Wen Zhao on 2/19/16.
//

import Foundation

public class RouteRequest {
    public var url: String
    public var parameters: [String: String]?
    public var requestData: AnyObject?
    
    public init (url: String, parameters: [String: String]?, data: AnyObject?) {
        self.url = url
        
        if let parameters = parameters {
            self.parameters = parameters
        }
        
        if let data = data {
            self.requestData = data
        }
    }
    
    public func getParam(name: String) -> String? {
        var param: String?
        if (parameters != nil) {
            param = parameters![name]
        }
        return param;
    }
    
    public func setParam(name: String, value: String) {
        parameters = parameters ?? [String: String]()
        parameters![name] = value
    }
    
}
