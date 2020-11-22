//
//  JSONEncoderTests.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import XCTest
@testable import NetworkManager

class JSONEncoderTests: XCTestCase {
    
    var mockRequest: URLRequest!
    
    var mockParameters: RequestParameters!
    
    override func setUp() {
        super.setUp()
        
        mockRequest = URLRequest(url: URL.nullURL)
        
        mockParameters = ["date": "05-21-1980"]
    }
    
    override func tearDown() {
        super.tearDown()
        
        mockRequest = nil
        
        mockParameters = nil
    }
    
    func testURL() {
                
        do {
            
            let url = mockRequest.url
            
            try JSONParameterEncoder.encode(urlRequest: &mockRequest, with: mockParameters)
            
            XCTAssertEqual(mockRequest.url, url, "Unexpected URL modification on JSON Paramenter Encoding")
            
        } catch {
            XCTFail("Unexpected error during JSON Parameter encoding \(error.localizedDescription)")
        }
    }
    
    func testHTTPBody () {
        
        do {
            
            let mockData = try! JSONSerialization.data(withJSONObject: mockParameters!, options: .prettyPrinted)
            
            try JSONParameterEncoder.encode(urlRequest: &mockRequest, with: mockParameters)
            
            XCTAssertEqual(mockRequest.httpBody, mockData, "Unexpected HTTP Body on JSON Paramenter Encoding")
            
        } catch {
            XCTFail("Unexpected error during JSON Parameter encoding \(error.localizedDescription)")
        }
    }
    
    func testHTTPHeader() {
        
        let headerField = "Content-Type"
        
        do {
            
            try JSONParameterEncoder.encode(urlRequest: &mockRequest, with: mockParameters)
            
            XCTAssertEqual(mockRequest.value(forHTTPHeaderField: headerField), "application/json")
            
        } catch {
            XCTFail("Unexpected error during JSON Parameter encoding \(error.localizedDescription)")
        }
    }
}
