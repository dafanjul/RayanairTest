//
//  NetworkError.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidURL
    case serverError(Int?)
}
