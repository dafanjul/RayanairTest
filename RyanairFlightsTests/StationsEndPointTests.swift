//
//  StationsEndPointTests.swift
//  RyanairFlightsTests
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import RyanairFlights

class StationsEndPointTests: XCTestCase {

    var sut: RyanairClient!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = RyanairClient(urlSession: mockSession)
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testStationsListEndPoint_ShouldCreateURL() {
        let sut = RyanairClient.StationListEndPoint()
        
        let urlComponents = sut.urlComponents
        
        XCTAssertEqual(urlComponents.scheme, "https")
        XCTAssertEqual(urlComponents.host, "tripstest.ryanair.com")
        XCTAssertEqual(urlComponents.path, "/static/stations.json")
    }

    func testSuccessResponse() {
        let completionCalled = expectation(description: "completion called")
        
        sut.requestStations { (result, error) in
            XCTAssertEqual(result?.count, 295)
            completionCalled.fulfill()
        }
        
        let response = generateSuccessResponseFrom(filename: "StationsListResponse")
        mockSession.completionReceived?(response.jsonData, response.response, nil)
        
        waitForExpectations(timeout: 2, handler: nil)
    }

}
