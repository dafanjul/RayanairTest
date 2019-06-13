//
//  NetworkActivityType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// Protocol to be conformed by entity handling the network activity indicator
protocol NetworkActivityType {
    
    /// function called when network starts a request
    static func startedRequest()
    
    /// function called when network stops a request
    static func stoppedRequest()
    
}
