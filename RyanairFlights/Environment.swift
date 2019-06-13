//
//  Environment.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// Protocol to define environments
protocol Environment {
    
    /// scheme used in environment
    var scheme: String { get }
    
    /// host used in environment
    var host: String { get }
    
}

struct TripsEnvironment: Environment {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "tripstest.ryanair.com"
    }
    
}

struct FlightsEnvironment: Environment {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "sit-nativeapps.ryanair.com"
    }
    
}
