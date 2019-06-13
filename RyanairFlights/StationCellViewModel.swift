//
//  StationCellViewModel.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

struct StationCellViewModel: CellIdentificableViewModel {
    
    let station: Station
    let cellIdentifier = "stationCell"
    
    var title: String {
        return station.name
    }
    var code: String {
        return station.code
    }
    
}

extension StationCellViewModel: Filtrable {
    
    func contains(_ text: String) -> Bool {
        return station.name.lowercased().contains(text.lowercased()) || station.code.lowercased().contains(text.lowercased())
    }
}
