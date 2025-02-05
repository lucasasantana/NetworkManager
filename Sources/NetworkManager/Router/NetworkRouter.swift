//
//  NetworkRouter.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

/// The result of a task on NetworkResult
public enum NetworkRouterResult {
    case success(result: Data?, response: URLResponse)
    case failure(NetworkRouterError)
}

/// The completion block associated with a NetworkRouter callback
public typealias NetworkRouterCompletion = (NetworkRouterResult) -> ()

/// Describes an Netowork Router Object
public protocol NetworkRouter: AnyObject {
    
    /// The endpoint type of this router
    associatedtype EndPoint: NetworkRouterEndpoint
    
    /// Request a data task to an endpoint
    /// - Parameters:
    ///   - route: The endpoint data
    ///   - completion: Callback containing the result of the operation
    func request(route: EndPoint, completion: @escaping NetworkRouterCompletion)
    
    /// Request a data task to an endpoint
    /// - Parameters:
    ///   - route: The endpoint data
    ///   - cachePolicy: The cache policy of the session
    ///   - completion: Callback containing the result of the operation
    func request(route: EndPoint, cachePolicy: NetworkCachePolice, completion: @escaping NetworkRouterCompletion)
    
    /// Request a data task to an endpoint
    /// - Parameters:
    ///   - route: The endpoint data
    ///   - timeout: The maximum time to wait for the response
    ///   - completion: Callback containing the result of the operation
    func request(route: EndPoint, timeout: TimeInterval, completion: @escaping NetworkRouterCompletion)
    
    /// Request a data task to an endpoint
    /// - Parameters:
    ///   - route: The endpoint data
    ///   - cachePolicy: The cache policy of the session
    ///   - timeout: The maximum time to wait for the response
    ///   - completion:  Callback containing the result of the operation
    func request(route: EndPoint, cachePolicy: NetworkCachePolice, timeout: TimeInterval, completion: @escaping NetworkRouterCompletion)
    
    /// Suspend the current task operation
    func suspend()
    
    /// Resume the current task operation
    func resume()
    
    /// Cancel the curren task operation
    func cancel()
}
