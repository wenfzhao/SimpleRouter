class Pipline {
    
    func sendThroughPipline(request: RouteRequest, middleWares: [MiddleWare], handler: RouteHandlerClosure) -> RouteRequest {
        var completion = createCompletionClosure(request, handler: handler)
        for i in 0..<middleWares.count {
            completion = createClosure(request, closure: completion, middleWare: middleWares[i])
        }
        return completion(request)
    }
    
    func createClosure(request: RouteRequest, closure: MiddleWareClosure, middleWare: MiddleWare) -> MiddleWareClosure {
        func middleClosre(request: RouteRequest) -> RouteRequest {
            return middleWare.handle(request, closure: closure)
        }
        return middleClosre
    }
    
    func createCompletionClosure(request: RouteRequest, handler: RouteHandlerClosure) -> MiddleWareClosure {
        func middleHandle(request: RouteRequest) -> RouteRequest {
            return handler(request)
        }
        return middleHandle
    }
    
}
