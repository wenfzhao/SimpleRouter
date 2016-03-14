# SimpleRouter
A Simple Laravel/Lumen Inspired Url-Based Router Library With Middleware Support Written Entirely in Swift


## Installation

### CocoaPods
You can install SimpleRouter via CocoaPods by adding it to your `Podfile`:

	use_frameworks!

	source 'https://github.com/CocoaPods/Specs.git'
	platform :ios, '8.0'

	pod 'SimpleRouter', '~> 3.0'
	
And run `pod install`.


## Usage
   
### Routing handler

Define a route:

```swift
let router = Router.sharedInstance
router.map("/album/:albumId", handler: { (request: RouteReqest) -> (RouteReqest) in
    if let albumId = request.getParam("albumId") {
        //display album here
    }
    return request
})
```

Initialize a route request:

```swift
Router.sharedInstance.routeURL("/album/123?name=hello&year=2016") 
// The handler function will be called with parameters ["albumId": "123", "name": "hell", "year": "2016"].
```



### Named Routes

Define a named route:

```swift
let router = Router.sharedInstance
router.map("/album/:albumId", name: "albumDetail", handler: { (request: RouteReqest) -> (RouteReqest) in
    if let albumId = request.getParam("albumId") {
        //display album here
    }
    return request
})
```


Get the named route url from the router:

```swift
let url = Router.sharedInstance.getRouteURL("albumDetail", parameters: ["albumId": "123"]) 
// url = "/album/123"
```


### Middlewares

There are two types of Middlewares - Before Middleware and After Middleware. Before Middleware is executed before hitting the route handler. After Middleware is executed after the route handler.

Create an After middleware:
```swift
class StatsMiddleware: Middleware {
    
    func handle(inRequest: RouteRequest, closure: MiddlewareClosure) -> RouteRequest {
        let request = closure(inRequest)
        
        //record stats here
        return request
    }
    
}
```

Create a Before middleware:
```swift
class BeforeMiddleware: Middleware {
    
    func handle(inRequest: RouteRequest, closure: MiddlewareClosure) -> RouteRequest {
        //put logics executed before the route handler
        //inRequest.setParam("pageId", "5")
        
        return closure(inRequest)
    }
    
}
```

Adding middlewares to route:
```swift
let middlewares = [BeforeMiddleware(), AfterMiddleware()]
let router = Router.sharedInstance
router.map("/album/:albumId", handler: { (request: RouteReqest) -> (RouteReqest) in
    if let albumId = request.getParam("albumId") {
        //display album here
    }
    return request
}).withMiddlewares(middlewares)
```

## Deep Linking to App

Install the Test app: 
Open simplerouter://album/2 in safari
