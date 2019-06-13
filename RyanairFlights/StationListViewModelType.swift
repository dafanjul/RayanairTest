//
//  AirportListViewModelType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A view model type with actions and information required by Airport List View
protocol StationListViewModelType {
    
    /// Title to display
    var title: String { get }
    
    /// Tells its needed to refresh the data
    var didUpdate: (() -> Void)? { get set }
    
    /// Tells its needed to refresh the data
    var displayMessage: ((String) -> Void)? { get set }
    
    /// Table Data Source
    var tableDataSource: TableViewDataSource { get }
    
    /// Should call this function when view is removed
    func didFinish()
    
    /// Requests a search filter
    ///
    /// - Parameter text: text to search
    func filterContentForSearchText(_ text: String)
    
}
