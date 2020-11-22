//
//  NetworkEndpoint.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

public protocol NetworkEndpoint {
    
    var baseURL: URL          { get }
    var path: String          { get }
    var method: HTTPMethod    { get }
    var task: HTTPTask        { get }
    var headers: HTTPHeaders? { get }
    
}
