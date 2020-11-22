//
//  RouterTests.swift
//  
//
//  Created by Lucas Antevere Santana on 22/11/20.
//

import XCTest
@testable import NetworkManager

internal class MockDataTask: URLSessionProviderDataTask {
    
    var resumeCalled: Bool = false
    var suspendCalled: Bool = false
    var cancelCalled: Bool = false
    
    func resume() {
        resumeCalled = true
    }
    
    func suspend() {
        suspendCalled = true
    }
    
    func cancel() {
        cancelCalled = true
    }
}

internal class MockSessionProvider: URLSessionProvider {
    
    var receivedRequest: URLRequest?
    
    lazy var response: HTTPURLResponse = {
       
        let response = HTTPURLResponse(url: URL.nullURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        return response
    }()
    
    var shouldReturnError: Bool = false
    var shouldReturnEmptyResponse: Bool = false
    
    lazy var dataTask: MockDataTask = {
        return MockDataTask()
    }()
    
    enum MockError: Error {
        case test
    }
    
    func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionProviderDataTask {
        
        self.receivedRequest = request
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
            guard let self = self else {
                completion(nil, nil, nil)
                return
            }
            
            if self.shouldReturnEmptyResponse {
                completion(nil, nil, nil)
                
            } else if self.shouldReturnError {
                completion(nil, nil, MockError.test)
                
            } else {
                completion(nil, self.response, nil)
            }
        }
        
        return dataTask
    }
}

internal struct MockEndpoint: NetworkEndpoint {
  
    var baseURL: URL = .nullURL
    
    var path: String = "mock"
    
    var method: HTTPMethod  = .get
    
    var task: HTTPTask = {
        
        let parameter: RequestParameters = ["date": "05-21-1980"]
        
        return .requestWithParametersAndHeaders(bodyParameters: parameter, urlParameters: parameter, addtionalHeaders: ["header": "test"])
    }()
    
    mutating func emptyHeader() {
        
        let parameter: RequestParameters = ["date": "05-21-1980"]
        
        self.task = .requestWithParameters(bodyParameters: parameter, urlParameters: parameter)
    }
    
    mutating func onlyURL() {
        
        let parameter: RequestParameters = ["date": "05-21-1980"]
        
        self.task = .requestWithParameters(bodyParameters: nil, urlParameters: parameter)
    }
    
    mutating func onlyBody() {
        
        let parameter: RequestParameters = ["date": "05-21-1980"]
        
        self.task = .requestWithParameters(bodyParameters: parameter, urlParameters: nil)
    }
    
    mutating func emptyPar() {
        self.task = .request
    }
}


class RouterTests: XCTestCase {
    
    var mockSession: MockSessionProvider!
    
    var sut: Router<MockEndpoint>!
    
    override func setUp() {
        super.setUp()
        
        mockSession = MockSessionProvider()
        
        sut = Router(urlSession: mockSession)
    }
    
    override func tearDown() {
        super.tearDown()
        
        mockSession = nil
        sut = nil
    }
    
    func testRequestWithNoHeader() {
        
        var endpoint = MockEndpoint()
        
        endpoint.emptyHeader()
        
        sut.request(route: endpoint) { (_) in }
        
        XCTAssertNotNil(mockSession.receivedRequest)
        
        XCTAssertEqual(mockSession.receivedRequest?.url, URL(string: "mockEmptyURL.com/mock?date=05-21-1980"))
        
        XCTAssertNotNil(mockSession.receivedRequest?.httpBody)
        
        XCTAssertEqual(mockSession.receivedRequest?.httpMethod, endpoint.method.rawValue)
        
        XCTAssertEqual(mockSession.receivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testRequestWithHeader() {
        
        let endpoint = MockEndpoint()
                
        sut.request(route: endpoint) { (_) in }
        
        XCTAssertNotNil(mockSession.receivedRequest)
        
        XCTAssertEqual(mockSession.receivedRequest?.url, URL(string: "mockEmptyURL.com/mock?date=05-21-1980"))
        
        XCTAssertNotNil(mockSession.receivedRequest?.httpBody)
        
        XCTAssertEqual(mockSession.receivedRequest?.httpMethod, endpoint.method.rawValue)
        
        XCTAssertEqual(mockSession.receivedRequest?.value(forHTTPHeaderField: "header"), "test")
    }
    
    func testRequestWithOnlyURL() {
        
        var endpoint = MockEndpoint()
        
        endpoint.onlyURL()
        
        sut.request(route: endpoint) { (_) in }
        
        XCTAssertNotNil(mockSession.receivedRequest)
        
        XCTAssertEqual(mockSession.receivedRequest?.url, URL(string: "mockEmptyURL.com/mock?date=05-21-1980"))
        
        XCTAssertNil(mockSession.receivedRequest?.httpBody)
        
        XCTAssertEqual(mockSession.receivedRequest?.httpMethod, endpoint.method.rawValue)
        
        XCTAssertEqual(mockSession.receivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded; charset=utf-8")
    }
    
    func testRequestWithOnlyBody() {
        
        var endpoint = MockEndpoint()
        
        endpoint.onlyBody()
        
        sut.request(route: endpoint) { (_) in }
        
        XCTAssertNotNil(mockSession.receivedRequest)
        
        XCTAssertEqual(mockSession.receivedRequest?.url, URL(string: "mockEmptyURL.com/mock"))
        
        XCTAssertNotNil(mockSession.receivedRequest?.httpBody)
        
        XCTAssertEqual(mockSession.receivedRequest?.httpMethod, endpoint.method.rawValue)
        
        XCTAssertEqual(mockSession.receivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testRequestEmptyPar() {
        
        var endpoint = MockEndpoint()
        
        endpoint.emptyPar()
        
        sut.request(route: endpoint) { (_) in }
        
        XCTAssertNotNil(mockSession.receivedRequest)
        
        XCTAssertEqual(mockSession.receivedRequest?.url, URL(string: "mockEmptyURL.com/mock"))
        
        XCTAssertNil(mockSession.receivedRequest?.httpBody)
        
        XCTAssertEqual(mockSession.receivedRequest?.httpMethod, endpoint.method.rawValue)
        
        XCTAssertEqual(mockSession.receivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testEncoderError() {
        
        let exepct = XCTestExpectation()
        
        mockSession.shouldReturnError = true
        
        sut.request(route: MockEndpoint()) { (result) in
            
            switch result {
                case .success:
                    XCTFail("Unexpected sucess return during encoder error")
                    
                case .failure(let error):
                    
                    if case NetworkRouterError.taskError(let returnedError) = error {
                       XCTAssertNotNil(returnedError as? MockSessionProvider.MockError, "Unexpected error returned during encoder error")
                        
                    } else {
                        XCTFail("Unexpected error returned during encoder error")
                    }
            }
            
            exepct.fulfill()
        }
        
        wait(for: [exepct], timeout: 1.0)
    }
    
    func testResponse() {
        
        let exepct = XCTestExpectation()
        
        sut.request(route: MockEndpoint()) { [unowned self] (result) in
            
            switch result {
                
                case .success(_, let response):
                    XCTAssertEqual(response, mockSession.response)
                    
                case .failure:
                    XCTFail("Unexpected error returned during sucessful callback")
            }
            
            exepct.fulfill()
        }
        
        wait(for: [exepct], timeout: 1.0)
    }
    
    func testCachePolicy() {
        
        sut.request(route: MockEndpoint(), cachePolicy: .useProtocolCachePolicy) { (_) in}
        
        XCTAssertEqual(mockSession.receivedRequest?.cachePolicy, .useProtocolCachePolicy, "Diferent chace policy in request")
    }
    
    func testTimeOut() {
        
        let mockTime: TimeInterval =  4584213
        
        sut.request(route: MockEndpoint(), timeout: mockTime) { (_) in}
        
        XCTAssertEqual(mockSession.receivedRequest?.timeoutInterval, mockTime)
    }
    
    func testSuspend() {
        
        sut.request(route: MockEndpoint()) { (_) in}
        
        sut.suspend()
        
        XCTAssertTrue(mockSession.dataTask.suspendCalled, "Suspend of data task not called")
    }
    
    func testResume() {
        
        sut.request(route: MockEndpoint()) { (_) in}
        
        mockSession.dataTask.resumeCalled = false
        
        sut.resume()
        
        XCTAssertTrue(mockSession.dataTask.resumeCalled, "Resume of data task not called")
    }
    
    func testCancel() {
        
        sut.request(route: MockEndpoint()) { (_) in}
        
        sut.cancel()
        
        XCTAssertTrue(mockSession.dataTask.cancelCalled, "Cancel of data task not called")
    }
}
