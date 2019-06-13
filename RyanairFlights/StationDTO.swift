//
//  StationDTO.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct StationDTO: Decodable {
    
    let code: String
    let name: String
    let alternateName: String?
    
}

extension StationDTO {
    
    var translate: Station {
        return Station(code: code, name: name, alternateName: alternateName)
    }
    
}
