//
//  FlightsEndPoint.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

extension RyanairClient {
    
    struct FlightListEndPoint: EndPointType {
        typealias response = RyanairFligtssResponse<[TripDTO]>
        let parameters: FlightListParameters
        var urlParameters: [URLQueryItem] {
            return [
                URLQueryItem(name: "origin", value: parameters.originCode),
                URLQueryItem(name: "destination", value: parameters.destinationCode),
                URLQueryItem(name: "dateout", value: parameters.shortDepartureDate),
                URLQueryItem(name: "datein", value: ""),
                URLQueryItem(name: "flexdaysbeforeout", value: "3"),
                URLQueryItem(name: "flexdaysout", value: "3"),
                URLQueryItem(name: "flexdaysbeforein", value: "3"),
                URLQueryItem(name: "flexdaysin", value: "3"),
                URLQueryItem(name: "adt", value: parameters.adultsCount),
                URLQueryItem(name: "teen", value: parameters.teensCount),
                URLQueryItem(name: "chd", value: parameters.childrenCount),
                URLQueryItem(name: "roundtrip", value: String(false)),
                URLQueryItem(name: "ToUs", value: "AGREED")
            ]
        }
        var path: String {
            return "/api/v4/Availability"
        }
        
        var environment: Environment {
            return FlightsEnvironment()
        }
    }
    
    @discardableResult func requestFlights(parameters: FlightListParameters, completion: @escaping ([Flight]?, Error?)-> Void) -> URLSessionDataTask? {
        let userListRequest = FlightListEndPoint(parameters: parameters)
        return request(endpoint: userListRequest) { (response, error) in
            DispatchQueue.global(qos: .background).async {
                let translatedResponse = response?.trips.flatMap{ $0.translate }.sorted(by: { (lhs, rhs) -> Bool in
                    return lhs.date < rhs.date
                })
                DispatchQueue.main.async {
                    completion(translatedResponse, error)
                }
            }
        }
    }
    
}
