# SimpleRouter
A Simple Url-Based Router Library Written in Swift


## Usage
   
### Routing handler

Define a route:

```swift
let router = Router.sharedInstance
router.map("/album/:albumId", handler: { (request: RouteReqest) -> (Bool) in
    if let albumId = request.getParam("albumId") {
        //display album here
    }
    return true
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
router.map("/album/:albumId", name: "albumDetail", handler: { (request: RouteReqest) -> (Bool) in
    if let albumId = request.getParam("albumId") {
        //display album here
    }
    return true
})
```


Get the named route url from the router:

```swift
let url = Router.sharedInstance.getRouteURL("albumDetail", parameters: ["albumId": "123"]) 
// url = "/album/123"
```
