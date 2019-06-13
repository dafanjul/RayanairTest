//
//  InputParametersViewModel.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// Input coordinator type
protocol InputParametersCoordinatorType: AnyObject {
    
    /// Triggers flight search request with a given parameter
    ///
    /// - Parameter parameters: search parameters
    func searchFlightsWith(_ parameters: FlightListParameters)
    
    /// Triggers station list request
    ///
    /// - Parameter completion: completion called with Station list
    func selectStation(completion: @escaping (Station) -> Void)
}

class InputParametersViewModel {
    
    //MARK: - Properties
    
    var networkClient: APIClientType
    weak var coordinator: InputParametersCoordinatorType?
    var currentParameters = FlightListParameters()
    var title: String {
        return "Flight input parameters"
    }
    
    //MARK: - Events
    
    var didUpdate: (() -> Void)?
    
    //MARK: - Life cycle
    
    init(networkClient: APIClientType, coordinator: InputParametersCoordinatorType?) {
        self.networkClient = networkClient
        self.coordinator = coordinator
    }
    
    //MARK: - Helpers
    
    func searchFlights() {
        coordinator?.searchFlightsWith(currentParameters)
    }
    
    func selectStation(completion: @escaping (Station) -> Void) {
        coordinator?.selectStation(completion: completion)
    }
    
    func selectOriginStation() {
        selectStation { [weak self] (station) in
            self?.currentParameters.origin = station
            self?.didUpdate?()
        }
    }
    
    func selectDestinationStation() {
        selectStation { [weak self] (station) in
            self?.currentParameters.destination = station
            self?.didUpdate?()
        }
    }
}

extension InputParametersViewModel: InputParametersViewModelType {
    
    func setDepartureDate(_ date: Date) {
        currentParameters.departureDate = date
        didUpdate?()
    }
    
    func setAdultIndexOption(_ index: Int) {
        guard let newValue = Int(adultsOptions[index]) else {
            return
        }
        currentParameters.adults = newValue
        didUpdate?()
    }
    
    func setChildIndexOption(_ index: Int) {
        guard let newValue = Int(childrenOptions[index]) else {
            return
        }
        currentParameters.children = newValue
        didUpdate?()
    }
    
    func setTeenIndexOption(_ index: Int) {
        guard let newValue =  Int(teensOptions[index]) else {
            return
        }
        currentParameters.teens = newValue
        didUpdate?()
    }
    
    
    var adultsOptions: [String] {
        return (1...6).map{ String($0) }
    }
    
    var teensOptions: [String] {
        return (0...6).map{ String($0) }
    }
    
    var childrenOptions: [String] {
        return (0...6).map{ String($0) }
    }
    
    var originStationDescription: String? {
        return currentParameters.originCode
    }
    
    var destinationStationDescription: String? {
        return currentParameters.destinationCode
    }
    
    var departureDateDescription: String? {
        return currentParameters.shortDepartureDate
    }
    
    var adultsCount: String? {
        return currentParameters.adultsCount
    }
    
    var teensCount: String? {
        return currentParameters.teensCount
    }
    
    var childrenCount: String? {
        return currentParameters.childrenCount
    }
    
}
