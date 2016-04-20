//
//  Router.swift
//
//  Created by Wen Zhao on 2/19/16.
//

import Foundation

public typealias RouteHandlerClosure = (RouteRequest) -> RouteRequest

public class Router {
    
    public static let sharedInstance = Router()
    private let routeKey = "_routeIdentifierKey"
    private var routeMaps = NSMutableDictionary()
    private var namedRoutes = [String: Route]()
    
    private init() {
        
    }
    
    public func map(routePattern: String, name: String? = nil,  handler: RouteHandlerClosure) -> Route {
        let route = Route(pattern: routePattern, handler: handler, name: name)
        addRoute(route)
        return route
    }
    
    public func findRoute(url: String) -> Route? {
        let encodedUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        var route: Route?
        var maps = routeMaps
        let urlPathComponents = getPathComponents(encodedUrl)
        for i in 0 ..< urlPathComponents.count {
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
    
    public func getRouteUrl(routeName: String, parameters: [String: String]?) -> String? {
        var url: String?
        var urlParts = [String]()
        if let route = findRouteByName(routeName) {
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
    
    public func routeURL(url: String, data: AnyObject? = nil) {
        let encodedUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        if let route = findRoute(encodedUrl) {
            let params = getParamForRoute(encodedUrl, route: route)
            let request = RouteRequest(url: encodedUrl, parameters: params, data: data)
            let pipeline = Pipeline()
            pipeline.sendThroughPipline(request, middlewares: route.middlewares, handler: route.handler)
        }
    }
    
    private func addRoute(route: Route) {
        namedRoutes[route.name] = route
        
        var routePathComponents = getPathComponents(route.pattern)
        var map: NSMutableDictionary = routeMaps
        for i in 0 ..< routePathComponents.count {
            let pathComponent = routePathComponents[i]
            // new path
            if map[pathComponent] == nil {
                map[pathComponent] = NSMutableDictionary()
            }
            map = map[pathComponent] as! NSMutableDictionary
            
            if i == (routePathComponents.count - 1) {
                map[routeKey] = route
                return
            }
        }
    }
    
    private func getParamForRoute(url: String, route: Route) -> [String: String] {
        var parameters = [String: String]()
        
        // get parameters from route
        let routePathComponents = getPathComponents(route.pattern)
        let urlPathComponents = getPathComponents(url)
        for i in 0 ..< routePathComponents.count {
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
                if let range = queryPart.rangeOfString("=") {
                    let name = queryPart.substringToIndex(range.startIndex)
                    let value = queryPart.substringFromIndex(range.endIndex).stringByRemovingPercentEncoding
                    parameters[name] = value?.stringByRemovingPercentEncoding
                }
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
