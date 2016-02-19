//
//  Route.swift
//
//  Created by Wen Zhao on 2/19/16.
//

import Foundation

class Route {
    var pattern: String
    var name: String
    var handler: RouteHandlerClosure
    
    init(pattern: String, handler: RouteHandlerClosure, name: String?) {
        self.pattern = pattern
        self.handler = handler
        self.name = name ?? pattern
    }
}

extension Route: Swift.Printable, Swift.DebugPrintable {
    var description: String {
        return "\(pattern) -> \(handler)"
    }
    
    var debugDescription: String {
        return description
    }
}
