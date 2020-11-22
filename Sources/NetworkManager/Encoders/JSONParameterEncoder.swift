//
//  JSONParameterEncoder.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import Foundation
import os

public struct JSONParameterEncoder: RequestParameterEncoder {
    
    public static func encode(urlRequest request: inout URLRequest, with parameters: RequestParameters) throws {
        
        do {
            
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            request.httpBody = jsonAsData
            
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        } catch {
            
            if #available(OSX 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *), let identifier = Bundle.main.bundleIdentifier {
                
                let logger = Logger(subsystem: identifier, category: "JSON Network Encoder")
                                
                logger.error("Error when encoding JSON Paramenters: \(error.localizedDescription)")
                
            } else if let identifier = Bundle.main.bundleIdentifier {
               
                let log = OSLog(subsystem: identifier, category: "JSON Network Encoder")
                
                os_log("Error when encoding JSON Paramenters: %@", log: log, type: .error, error.localizedDescription)
                
            } else {
                print("Error when encoding JSON Paramenters: \(error.localizedDescription)")
            }
            
            throw EncoderError.encodingFailed
        }
    }
}
