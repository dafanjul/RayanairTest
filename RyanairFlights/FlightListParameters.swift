//
//  FlightListParameters.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct FlightListParameters {
    
    var origin: Station?
    var destination: Station?
    var departureDate = Date()
    var adults = 1
    var teens = 0
    var children = 0
    
    var originCode: String {
        return origin?.code ?? ""
    }
    
    var destinationCode: String {
        return destination?.code ?? ""
    }
    
    var shortDepartureDate: String? {
        return departureDate.shorStringtDateFormatter()
    }
    
    var adultsCount: String? {
        return String(adults)
    }
    
    var teensCount: String? {
        return String(teens)
    }
    
    var childrenCount: String? {
        return String(children)
    }
    
}
