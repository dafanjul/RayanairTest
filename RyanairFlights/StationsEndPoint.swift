//
//  StationsEndPoint.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

extension RyanairClient {
    
    struct StationListEndPoint: EndPointType {
        typealias response = RyanairStationsResponse<[StationDTO]>
        
        var path: String {
            return "/static/stations.json"
        }
    }
    
    
    @discardableResult func requestStations(completion: @escaping ([Station]?, Error?) -> Void) -> URLSessionDataTask? {
        let userListRequest = StationListEndPoint()
        return request(endpoint: userListRequest) { (response, error) in
            DispatchQueue.global(qos: .background).async {
                let translatedResponse = response?.stations.map{ $0.translate }.sorted(by: { (lhs, rhs) -> Bool in
                    return lhs.name < rhs.name
                })
                DispatchQueue.main.async {
                    completion(translatedResponse, error)
                }
            }
        }
    }
    
}
