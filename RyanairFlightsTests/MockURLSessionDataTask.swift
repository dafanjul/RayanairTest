//
//  MockURLSessionDataTask.swift
//  RyanairFlightsTests
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    var resumeCalled = false
    
    override func resume() {
        resumeCalled = true
    }
    
}
