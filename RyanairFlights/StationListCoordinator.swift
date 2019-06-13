//
//  StationListCoordinator.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

import UIKit

class StationListCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private var networkClient: APIClientType
    weak var parentCoordinator: Coordinator?
    var completion: ((Station) -> Void)?
    
    init(navigationController: UINavigationController, networkClient: APIClientType) {
        self.navigationController = navigationController
        self.networkClient = networkClient
    }
    
    func start() {
        let viewController = StationListViewController.instantiate()
        let viewModel = StationListViewModel(networkClient: networkClient, coordinator: self)
        viewModel.setFilterStatusProvider(viewController)
        viewModel.completion = completion
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension StationListCoordinator: StationListCoordinatorType {
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
