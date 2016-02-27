typealias MiddleWareClosure = (RouteRequest) -> RouteRequest

protocol MiddleWare {
    func handle(request: RouteRequest, closure: MiddleWareClosure) -> RouteRequest
}

class BeforeMiddleWare: MiddleWare {
    func handle(request: RouteRequest, closure: MiddleWareClosure) -> RouteRequest {
        print("before middle handling")
        return closure(request)
    }
}

class AfterMiddleWare: MiddleWare {
    func handle(request: RouteRequest, closure: MiddleWareClosure) -> RouteRequest {
        let ret = closure(request)
        print("after middle handling")
        return ret
    }
}
