//
//  FlightsEndPointTests.swift
//  RyanairFlightsTests
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import RyanairFlights

class FlightsEndPointTests: XCTestCase {

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
        let expectedOriginStation = Station(code: "STD", name: "Stansted", alternateName: nil)
        let expectedDestinationStation = Station(code: "DUB", name: "Dublin", alternateName: nil)
        let expectedAdults = 2
        let expectedTeens = 3
        let expectedChildren = 2
        let expectedDate = Date()
        let paramters = FlightListParameters(origin: expectedOriginStation, destination: expectedDestinationStation, departureDate: expectedDate, adults: expectedAdults, teens: expectedTeens, children: expectedChildren)
        let sut = RyanairClient.FlightListEndPoint(parameters: paramters)
        
        let urlComponents = sut.urlComponents
        
        XCTAssertEqual(urlComponents.scheme, "https")
        XCTAssertEqual(urlComponents.host, "sit-nativeapps.ryanair.com")
        XCTAssertEqual(urlComponents.path, "/api/v4/Availability")
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "origin"), expectedOriginStation.code)
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "destination"), expectedDestinationStation.code)
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "dateout"), expectedDate.shorStringtDateFormatter())
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "adt"), String(expectedAdults))
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "teen"), String(expectedTeens))
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "chd"), String(expectedChildren))
    }
    
    func testSuccessResponse() {
        let expectedOriginStation = Station(code: "STD", name: "Stansted", alternateName: nil)
        let expectedDestinationStation = Station(code: "DUB", name: "Dublin", alternateName: nil)
        let expectedAdults = 2
        let expectedTeens = 3
        let expectedChildren = 2
        let expectedDate = Date()
        let paramters = FlightListParameters(origin: expectedOriginStation, destination: expectedDestinationStation, departureDate: expectedDate, adults: expectedAdults, teens: expectedTeens, children: expectedChildren)
        
        let completionCalled = expectation(description: "completion called")

        sut.requestFlights(parameters: paramters) { (result, error) in
            XCTAssertEqual(result?.count, 53)
            completionCalled.fulfill()
        }

        let response = generateSuccessResponseFrom(filename: "FlightListResponse")
        mockSession.completionReceived?(response.jsonData, response.response, nil)

        waitForExpectations(timeout: 2, handler: nil)
    }


}
