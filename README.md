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
