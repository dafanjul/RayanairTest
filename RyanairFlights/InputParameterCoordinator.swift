//
//  InputParameterCoordinator.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class InputParameterCoordinator: NSObject, InputParametersCoordinatorType, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private weak var window: UIWindow?
    private lazy var networkClient: APIClientType = {
        return RyanairClient()
    }()
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
        
    func start() {
        window?.rootViewController = navigationController
        let viewController = InputParametersViewController.instantiate()
        viewController.viewModel = InputParametersViewModel(networkClient: networkClient, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
        window?.makeKeyAndVisible()
    }
    
    func searchFlightsWith(_ parameters: FlightListParameters) {
        let child = FlightListCoordinator(navigationController: navigationController, networkClient: networkClient, flightParameters: parameters)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func selectStation(completion: @escaping (Station) -> Void) {
        let child = StationListCoordinator(navigationController: navigationController, networkClient: networkClient)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.completion = completion
        child.start()
    }
    
}
