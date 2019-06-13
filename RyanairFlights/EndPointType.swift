//
//  EndPointType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// Protocol to be conformed by end points
protocol EndPointType {
    associatedtype response: Decodable
    
    /// Environment information
    var environment: Environment { get }
    /// HTTP method used
    var httpMethod: HTTPMethod { get }
    /// URL path
    var path: String { get }
    /// URL parameters
    var urlParameters: [URLQueryItem] { get }
    /// Tells to process the data received
    ///
    /// - Parameter data: data received to process
    /// - Returns: any given error
    func processResponse(data: Data) -> (response?, Error?)
}

extension EndPointType {
    
    var environment: Environment {
        return TripsEnvironment()
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var urlParameters: [URLQueryItem] {
        return []
    }
    
    func processResponse(data: Data) -> (response?, Error?) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        guard let decodedData = try? decoder.decode(response.self, from: data) else {
            return (nil, NetworkError.invalidData)
        }
        
        return (decodedData, nil)
    }
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = environment.scheme
        urlComponents.host = environment.host
        urlComponents.path = path
        urlComponents.queryItems = urlParameters
        
        return urlComponents
    }
}

private extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
