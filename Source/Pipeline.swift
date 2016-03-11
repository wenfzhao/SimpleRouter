public class Pipeline {
    
    public func sendThroughPipline(request: RouteRequest, middlewares: [Middleware], handler: RouteHandlerClosure) -> RouteRequest {
        var completion = createCompletionClosure(request, handler: handler)
        let reversedMiddlewares:[Middleware] = middlewares.reverse()
        for i in 0..<middlewares.count {
            completion = createClosure(request, closure: completion, middleware: reversedMiddlewares[i])
        }
        return completion(request)
    }
    
    public func createClosure(request: RouteRequest, closure: MiddlewareClosure, middleware: Middleware) -> MiddlewareClosure {
        func middleClosre(request: RouteRequest) -> RouteRequest {
            return middleware.handle(request, closure: closure)
        }
        return middleClosre
    }
    
    public func createCompletionClosure(request: RouteRequest, handler: RouteHandlerClosure) -> MiddlewareClosure {
        func middleHandle(request: RouteRequest) -> RouteRequest {
            return handler(request)
        }
        return middleHandle
    }
    
}
