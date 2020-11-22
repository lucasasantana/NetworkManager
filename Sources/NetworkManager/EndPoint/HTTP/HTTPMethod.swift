//
//  HTTPMethod.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

/// Describes the HTTP method of the request
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
