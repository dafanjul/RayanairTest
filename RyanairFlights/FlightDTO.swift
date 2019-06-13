//
//  FlightDTO.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct FlightDTO: Decodable {
    
    let flightNumber: String
    let regularFare: RegularFareDTO
    
}

extension FlightDTO {

    var translateFares: [Fare] {
        return regularFare.translate
    }
    
}
