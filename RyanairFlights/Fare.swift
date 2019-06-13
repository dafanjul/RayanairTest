//
//  Fare.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct Fare {
    
    let type: FareType
    let amount: Decimal
    let count: Int
    
    var description: String {
        return " \(type.description) (\(amount))"
    }
    
}

enum FareType: String {
    
    case adt
    case teen
    case chd
    
    var description: String {
        switch self {
        case .adt:
            return "Adult"
        case .chd:
            return "Children"
        case .teen:
            return "Teen"
        }
    }
    
}
