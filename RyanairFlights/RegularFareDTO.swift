//
//  RegularFareDTO.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct RegularFareDTO: Decodable {
    
    let fareClass: String
    let fares: [FareDTO]
    
}

extension RegularFareDTO {
    
    var translate: [Fare] {
        return fares.map{ $0.translate }
    }
    
}
