//
//  URLEncoderTests.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import XCTest
@testable import NetworkManager

class URLEncoderTests: XCTestCase {
    
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
    
    func testEmptyURL() {
        
        mockRequest.url = nil
        
        do {
            
            try URLParameterEncoder.encode(urlRequest: &mockRequest, with: mockParameters)
            
            XCTFail("Error expected when url is nil")
            
        } catch let error as EncoderError {
            XCTAssertEqual(error, .missingURL, "Expected EncoderError.missingURL when url is nil but another type is being returned instead")
            
        } catch {
            XCTFail("Expected Encoder Error type when url is nil but another type is returned instead")
        }
    }
    
    func testHTTPHeader() {
        
        let headerField = "Content-Type"
        
        do {
            
            try URLParameterEncoder.encode(urlRequest: &mockRequest, with: mockParameters)
            
            XCTAssertEqual(mockRequest.value(forHTTPHeaderField: headerField), "application/x-www-form-urlencoded; charset=utf-8")
            
        } catch {
            XCTFail("Unexpected error during URL Parameter encoding \(error.localizedDescription)")
        }
    }
    
    func testQueryItems() {
        
        do {
            
            try URLParameterEncoder.encode(urlRequest: &mockRequest, with: mockParameters)
            
            XCTAssertEqual(mockRequest.url, URL(string: "mockEmptyURL.com/?date=05-21-1980"))
    
        }  catch {
            XCTFail("Unexpected error during URL Parameter encoding \(error.localizedDescription)")
        }
    }
    
    func testEmptyQueryItems() {
        
        do {
            
            let url = mockRequest.url
            
            try URLParameterEncoder.encode(urlRequest: &mockRequest, with: [:])
            
            XCTAssertEqual(mockRequest.url, url)
            
        }  catch {
            XCTFail("Unexpected error during URL Parameter encoding \(error.localizedDescription)")
        }
    }
}
