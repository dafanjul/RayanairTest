//
//  MockURLSession.swift
//  RyanairFlightsTests
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    var completionReceived: ((Data?, URLResponse?, Error?) -> Void)?
    var requestReceived: URLRequest?
    var dataTaskToReturn: MockURLSessionDataTask?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionReceived = completionHandler
        requestReceived = request
        return dataTaskToReturn ?? MockURLSessionDataTask()
    }
    
}
