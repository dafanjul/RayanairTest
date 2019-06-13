//
//  TripDateDTO.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct TripDateDTO: Decodable {
    
    let dateOut: Date
    let flights: [FlightDTO]
    
}

extension TripDateDTO {
    
    var translate: [Flight] {
        return flights.map{ Flight(date: dateOut, flightNumber: $0.flightNumber, fares: $0.translateFares ) }
    }
    
}
