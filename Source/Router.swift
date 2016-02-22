//
//  Router.swift
//
//  Created by Wen Zhao on 2/19/16.
//

import Foundation

typealias RouteHandlerClosure = (RouteRequest) -> Bool

class Router {
    
    static let sharedInstance = Router()
    private let routeKey = "_routeIdentifierKey"
    private var routeMaps = NSMutableDictionary()
    private var namedRoutes = [String: Route]()
    
    private init() {
        
    }
    
    func map(routePattern: String, name: String? = nil,  handler: RouteHandlerClosure) {
        let route = Route(pattern: routePattern, handler: handler, name: name)
        addRoute(route)
    }
    
    func findRoute(url: String) -> Route? {
        var route: Route?
        var maps = routeMaps
        let urlPathComponents = getPathComponents(url)
        for var i = 0; i < urlPathComponents.count; i++ {
            let pathComponent = urlPathComponents[i]
            for (key, value) in maps {
                if maps[pathComponent] != nil { //no exact match
                    // reach the end
                    if i == (urlPathComponents.count - 1) {
                        let routeMap = maps[pathComponent] as! NSMutableDictionary
                        route = routeMap[routeKey] as? Route
                        return route
                    }
                    maps = maps[pathComponent] as! NSMutableDictionary
                    break
                } else if key.hasPrefix(":") { //param match
                    // reach the end
                    if i == (urlPathComponents.count - 1) {
                        route = value[routeKey] as? Route
                        return route
                    }
                    maps = maps[String(key)] as! NSMutableDictionary
                    break
                }
            }
        }
        return route
    }
    
    func findRouteByName(name: String) -> Route? {
        return namedRoutes[name]
    }
    
    func getRouteUrl(routeName: String, parameters: [String: String]?) -> String? {
        var url: String?
        var urlParts = [String]()
        if let route = findRouteByName(routeName) {
            url = route.pattern
            if (parameters != nil) {
                let routePathComponents = getPathComponents(route.pattern)
                for pathComponent in routePathComponents {
                    if pathComponent.hasPrefix(":"),
                        let value = parameters![pathComponent.substringFromIndex(pathComponent.startIndex.advancedBy(1))] {
                        urlParts.append(value)
                    } else {
                        urlParts.append(pathComponent)
                    }
                }
            }
            let urlString = urlParts.joinWithSeparator("/")
            if urlString != "" {
                url = urlString.hasPrefix("//") ? urlString.substringFromIndex(urlString.startIndex.advancedBy(1)) : urlString
            }
        }
        return url
    }
    
    func routeURL(url: String, data: AnyObject?) {
        if let route = findRoute(url) {
            let params = getParamForRoute(url, route: route)
            let request = RouteRequest(url: url, parameters: params, data: data)
            route.handler(request)
        }
    }
    
    private func addRoute(route: Route) {
        namedRoutes[route.name] = route
        
        var routePathComponents = getPathComponents(route.pattern)
        var map: NSMutableDictionary = routeMaps
        for var i = 0; i < routePathComponents.count; i++ {
            let pathComponent = routePathComponents[i]
            // new path
            if map[pathComponent] == nil {
                if i == (routePathComponents.count - 1) {
                    map[pathComponent] = NSMutableDictionary(dictionary: [routeKey: route])
                    return
                }
                map[pathComponent] = NSMutableDictionary()
            }
            map = map[pathComponent] as! NSMutableDictionary
        }
    }
    
    private func getParamForRoute(url: String, route: Route) -> [String: String] {
        var parameters = [String: String]()
        
        // get parameters from route
        let routePathComponents = getPathComponents(route.pattern)
        let urlPathComponents = getPathComponents(url)
        for var i = 0; i < routePathComponents.count; i++ {
            let pathComponent = routePathComponents[i]
            if pathComponent.hasPrefix(":") {
                let name = pathComponent.substringFromIndex(pathComponent.startIndex.advancedBy(1))
                parameters[name] = urlPathComponents[i]
            }
        }
        
        // get parameters from url query string
        if let url = NSURL(string: url) where (url.query != nil) {
            let queryParts = url.query!.componentsSeparatedByString("&")
            for queryPart in queryParts {
                let param = queryPart.componentsSeparatedByString("=")
                let name = param[0]
                let value = param[1]
                parameters[name] = value
            }
        }
        
        return parameters
    }
    
    private func getPathComponents(path: String) -> [String] {
        var pathComponents = [String]()
        
        if let url = NSURL(string: path) where (url.pathComponents != nil) {
            pathComponents += url.pathComponents!
        }
        
        return pathComponents
    }
    
}
