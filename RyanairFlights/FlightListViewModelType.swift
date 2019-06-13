//
//  FlightListViewModelType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A view model type with actions and information required by Flight List View
protocol FlightListViewModelType {
    
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

}
