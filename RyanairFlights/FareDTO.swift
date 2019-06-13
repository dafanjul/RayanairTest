//
//  FareDTO.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct FareDTO: Decodable {
    
    let fareType: FareTypeDTO
    let amount: Decimal
    let count: Int
    
    private enum CodingKeys: String, CodingKey {
        case fareType = "type"
        case amount
        case count
    }
    
}

extension FareDTO {
    var translate: Fare {
        return Fare(type: fareType.translate, amount: amount, count: count)
    }
}

enum FareTypeDTO: String, Decodable {
    case adt = "ADT"
    case teen = "TEEN"
    case chd = "CHD"
    
    var translate: FareType {
        switch self {
        case .adt:
            return FareType.adt
        case .teen:
            return FareType.teen
        case .chd:
            return FareType.chd
        }
    }
}
