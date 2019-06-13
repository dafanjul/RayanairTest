//
//  ConfigurableCell.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A type that can be configured
protocol ConfigurableCell {
    
    /// Tells to configure the cell
    ///
    /// - Parameter viewModel: view model that provides the data
    func setup(using viewModel: CellIdentificableViewModel)
    
}

/// Cell to use in tandem with TableViewDataSource
protocol CellIdentificableViewModel {
    
    /// cell identifier
    var cellIdentifier: String { get }
}
