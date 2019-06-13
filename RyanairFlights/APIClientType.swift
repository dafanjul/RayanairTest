//
//  APIClientType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A type that handle data network requests
protocol APIClientType {
    
    /// Requests station list
    ///
    /// - Parameter completion: completion called once the `Station` array is available and any given error
    /// - Returns: session data task
    @discardableResult func requestStations(completion: @escaping ([Station]?, Error?)-> Void) -> URLSessionDataTask?
    
    /// Requests flight availability
    ///
    /// - Parameter completion: completion called once the `Station` array is available and any given error
    /// - Returns: session data task
    @discardableResult func requestFlights(parameters: FlightListParameters, completion: @escaping ([Flight]?, Error?)-> Void) -> URLSessionDataTask?

}
