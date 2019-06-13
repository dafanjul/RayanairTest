//
//  SearchFlightsCoordinator.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class FlightListCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let networkClient: APIClientType
    weak var parentCoordinator: Coordinator?
    private let flightParameters: FlightListParameters

    init(navigationController: UINavigationController, networkClient: APIClientType, flightParameters: FlightListParameters) {
        self.navigationController = navigationController
        self.networkClient = networkClient
        self.flightParameters = flightParameters
    }
    
    func start() {
        let viewController = FlightListViewController.instantiate()
        viewController.viewModel = FlightListsViewModel(networkClient: networkClient, coordinator: self, searchParameters: flightParameters)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension FlightListCoordinator: FlightListCoordinatorType {
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

}
