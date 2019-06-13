//
//  Flight.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct Flight {
    
    let date: Date
    let flightNumber: String
    let fares: [Fare]
    
    var fareDescription: String {
        return fares.map{$0.description}.joined(separator: "-")
    }
    
}
