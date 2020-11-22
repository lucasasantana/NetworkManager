//
//  RequestParameters.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

public typealias RequestParameters = [String: Any]

public protocol RequestParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws
}
