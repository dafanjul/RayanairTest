//
//  RyanairFlightResponse.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct RyanairFligtssResponse<T: Decodable>: Decodable {
    
    let trips: T
    
}
