//
//  StationListViewModel.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

protocol StationListCoordinatorType: AnyObject {
    func didFinish()
    func goBack()
}

class StationListViewModel {
    
    //MARK: - Properties
    
    private lazy var list = FiltrableListType<StationCellViewModel>()
    private var currentOperation: URLSessionDataTask?
    var networkClient: APIClientType
    weak var coordinator: StationListCoordinatorType?
    var title: String {
        return "Stations"
    }
    lazy var tableDataSource: TableViewDataSource = {
        let dataSource = TableViewDataSource(dataProvider: self)
        return dataSource
    }()
    
    //MARK: - Events
    
    var completion: ((Station) -> Void)?
    var didUpdate: (() -> Void)?
    var displayMessage: ((String) -> Void)?
    
    func setFilterStatusProvider(_ provider: SearchFilterStatusProvider) {
        list.filterStatusProvider = provider
    }
    
    // MARK: - Life cycle
    
    init(networkClient: APIClientType, coordinator: StationListCoordinatorType?) {
        self.networkClient = networkClient
        self.coordinator = coordinator
        requestStations()
    }
    
    // MARK: - Helpers
    
    private func requestStations() {
        currentOperation = networkClient.requestStations { [weak self] (response, error) in
            guard let response = response else {
                self?.displayMessage?("Network error")
                return
            }
            guard !response.isEmpty else {
                self?.displayMessage?("No results")
                return
            }
            self?.list.setList(response.map{ StationCellViewModel(station: $0)})
            self?.didUpdate?()
        }
    }
    
}

extension StationListViewModel: StationListViewModelType {
    
    func filterContentForSearchText(_ text: String) {
        list.filterContentForSearchText(text) { [weak self] in
            self?.didUpdate?()
        }
        
    }
    
    func didFinish() {
        coordinator?.didFinish()
        currentOperation?.cancel()
    }
    
}

extension StationListViewModel: ListDataProvider {
    
    func viewModelFor(_ index: Int) -> CellIdentificableViewModel? {
        return list.element(at: index)
    }
    
    var numberOfElements: Int {
        return list.numberOfElements
    }
    
    func didSelect(_ index: Int) {
        let element = list.element(at: index)
        completion?(element.station)
        coordinator?.goBack()
    }
    
}
