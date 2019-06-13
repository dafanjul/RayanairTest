//
//  InputParametersViewModelType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A view model type with actions and information required by Input View
protocol InputParametersViewModelType {
    
    /// Title to display
    var title: String { get }
    
    /// Tells its needed to refresh the data
    var didUpdate: (() -> Void)? { get set }
        
    /// Returns origin description
    var originStationDescription: String? { get }
    
    /// Returns destination description
    var destinationStationDescription: String? { get }
    
    /// Returns departure date
    var departureDateDescription: String? { get }
    
    /// Returns adults number
    var adultsCount: String? { get }
    
    /// Returns teens number
    var teensCount: String? { get }
    
    /// Returns children number
    var childrenCount: String? { get }
    
    /// Returns available options for adults number
    var adultsOptions: [String] { get }
    
    /// Returns available options for teens number
    var teensOptions: [String] { get }
    
    /// Returns available options for children number
    var childrenOptions: [String] { get }
    
    /// Sets index option for adult number
    func setAdultIndexOption(_ index: Int)
    
    /// Sets index option for children number
    func setChildIndexOption(_ index: Int)
    
    /// Sets index option for teen number
    func setTeenIndexOption(_ index: Int) 
    
    /// Triggers flight search
    func searchFlights()
    
    /// Triggers origin station selection
    func selectOriginStation()
    
    /// Triggers origin station selection
    func selectDestinationStation()
    
    /// Sets departure date
    func setDepartureDate(_ date: Date)
    
}
