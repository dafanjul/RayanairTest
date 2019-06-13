//
//  URLQueryItems+Utils.swift
//  RyanairFlightsTests
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

extension Array where Element == URLQueryItem {
    
    func valueFor(key: String) -> String? {
        return self.filter({$0.name == key}).first?.value
    }
    
}
