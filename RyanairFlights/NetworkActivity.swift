//
//  NetworkActivity.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

struct NetworkActivity: NetworkActivityType {
    
    private static var networkActivities = 0
    
    static func startedRequest() {
        DispatchQueue.main.async {
            if NetworkActivity.networkActivities == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            NetworkActivity.networkActivities += 1
        }
    }
    
    static func stoppedRequest() {
        DispatchQueue.main.async {
            NetworkActivity.networkActivities -= 1
            if NetworkActivity.networkActivities == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
}
