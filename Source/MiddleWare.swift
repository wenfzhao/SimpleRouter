public typealias MiddleWareClosure = (RouteRequest) -> RouteRequest

public protocol MiddleWare {
    func handle(request: RouteRequest, closure: MiddleWareClosure) -> RouteRequest
}

public class BeforeMiddleWare: MiddleWare {
    public func handle(request: RouteRequest, closure: MiddleWareClosure) -> RouteRequest {
        print("before middle handling")
        return closure(request)
    }
}

public class AfterMiddleWare: MiddleWare {
    public func handle(request: RouteRequest, closure: MiddleWareClosure) -> RouteRequest {
        let ret = closure(request)
        print("after middle handling")
        return ret
    }
}
