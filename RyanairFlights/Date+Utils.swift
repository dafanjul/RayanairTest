//
//  Date+Utils.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

extension Date {
    
    func shorStringtDateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }

}
