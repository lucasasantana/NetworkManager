//
//  URLSessionProvider.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

public protocol URLSessionProvider {
    
    func dataTask(with request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionProviderDataTask
    
}

public protocol URLSessionProviderDataTask {
    
    func resume()
    
    func suspend()
    
    func cancel()
}

extension URLSessionDataTask: URLSessionProviderDataTask {}

extension URLSession: URLSessionProvider {
    
    public func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionProviderDataTask {
        self.dataTask(with: request, completionHandler: completion)
    }
}
