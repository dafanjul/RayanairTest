//
//  XCTestCase+Utils.swift
//  RyanairFlightsTests
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func generateSuccessResponseFrom(filename: String) -> (jsonData: Data?, response: HTTPURLResponse?)  {
        let jsonURL = Bundle.init(for: type(of: self)).url(forResource: filename, withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        let response = HTTPURLResponse(url: jsonURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (jsonData, response)
    }
}
