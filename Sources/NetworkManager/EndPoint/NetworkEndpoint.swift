//
//  NetworkEndpoint.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

public protocol NetworkEndpoint {
    
    /// The base url of the host (e.g: www.google.com)
    var baseURL: URL          { get }
    
    /// The path of the endpoint
    /// - Warning: Must include the first "/"
    ///
    /// E.g: The path of www.google.com/images becomes /images
    var path: String          { get }
    
    /// The HTTP Method of the endpoint
    var method: HTTPMethod    { get }
    
    /// The HTTP Request Parameters content
    var task: HTTPTask        { get }
}
