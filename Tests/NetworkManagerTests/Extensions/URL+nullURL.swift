//
//  URL+nullURL.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation

internal extension URL {
    
    static var nullURL: URL {
        return URL(string: "mockEmptyURL.com/")!
    }
}

