//
//  TripDTO.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct TripDTO: Decodable {
    
    let origin: String
    let destination: String
    let dates: [TripDateDTO]
    
}

extension TripDTO {
    
    var translate: [Flight] {
        return dates.flatMap{ $0.translate }
    }
    
}
