//
//  FlightListViewModel.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

protocol FlightListCoordinatorType: AnyObject {
    func didFinish()
}

class FlightListsViewModel {
    
    //MARK: - Properties
    private lazy var list = ListType<FlightCellViewModel>()
    private var currentOperation: URLSessionDataTask?
    var networkClient: APIClientType
    weak var coordinator: FlightListCoordinatorType?
    let searchParameters: FlightListParameters
    lazy var tableDataSource: TableViewDataSource = {
        let dataSource = TableViewDataSource(dataProvider: self)
        return dataSource
    }()
    var title: String {
        return "Results"
    }
    
    //MARK: - Events
    
    var didUpdate: (() -> Void)?
    var displayMessage: ((String) -> Void)?
    
    //MARK: - Life cycle
    
    init(networkClient: APIClientType, coordinator: FlightListCoordinatorType?, searchParameters: FlightListParameters) {
        self.networkClient = networkClient
        self.coordinator = coordinator
        self.searchParameters = searchParameters
        requestFlights()
    }
    
    //MARK: - Helpers
    
    private func requestFlights() {
        currentOperation = networkClient.requestFlights(parameters: searchParameters) { [weak self] (response, error) in
            guard let response = response else {
                self?.displayMessage?("Network error")
                return
            }
            guard !response.isEmpty else {
                self?.displayMessage?("No results")
                return
            }
            self?.list.setList(response.map{ FlightCellViewModel(flight: $0) })
            self?.didUpdate?()
        }
    }
}

extension FlightListsViewModel: FlightListViewModelType {
    
    func didFinish() {
        coordinator?.didFinish()
        currentOperation?.cancel()
    }
    
}

extension FlightListsViewModel: ListDataProvider {
    
    func viewModelFor(_ index: Int) -> CellIdentificableViewModel? {
        return list.element(at: index)
    }
    
    var numberOfElements: Int {
        return list.numberOfElements
    }
    
    func didSelect(_ index: Int) {
        //TODO: Action when flight is selected
    }
    
}
