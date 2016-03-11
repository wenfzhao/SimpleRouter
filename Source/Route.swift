//
//  Route.swift
//
//  Created by Wen Zhao on 2/19/16.
//

import Foundation

public class Route {
    public var pattern: String
    public var name: String
    public var handler: RouteHandlerClosure
    public var middlewares = [Middleware]()
    
    
    public init(pattern: String, handler: RouteHandlerClosure, name: String?) {
        self.pattern = pattern
        self.handler = handler
        self.name = name ?? pattern
    }
    
    public func withMiddlewares(middlewares: [Middleware]) -> Route {
        self.middlewares = middlewares
        return self
    }
}

extension Route: Swift.Printable, Swift.DebugPrintable {
    public var description: String {
        return "\(pattern) -> \(handler)"
    }
    
    public var debugDescription: String {
        return description
    }
}
