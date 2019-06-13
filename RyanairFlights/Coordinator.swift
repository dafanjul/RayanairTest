//
//  Coordinator.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

/// Coordinator for navigation
protocol Coordinator: AnyObject {
    
    /// Reference to child coordinators
    var childCoordinators: [Coordinator] { get set }
    
    /// Reference to Navigation Controller
    var navigationController: UINavigationController { get set }
    
    /// Triggers initial state
    func start()
}

extension Coordinator {
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
