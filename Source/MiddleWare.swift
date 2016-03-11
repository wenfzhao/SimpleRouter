public typealias MiddlewareClosure = (RouteRequest) -> RouteRequest

public protocol Middleware {
    func handle(request: RouteRequest, closure: MiddlewareClosure) -> RouteRequest
}
