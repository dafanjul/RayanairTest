//
//  FlightCellViewModel.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct FlightCellViewModel: CellIdentificableViewModel {
    
    let flight: Flight
    let cellIdentifier = "flightCell"
    
    var flightNumber: String {
        return flight.flightNumber
    }
    
    var date: String {
        return flight.date.shorStringtDateFormatter()
    }
    
    var fareDescription: String {
        return flight.fareDescription
    }
    
}
