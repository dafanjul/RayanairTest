//
//  ListDataProvider.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A type to tell the information regarding the data source
protocol ListDataProvider {
    
    /// The number of elements to display
    var numberOfElements: Int { get }
    /// Tells the `CellViewModel` view model for index parameter
    ///
    /// - Parameter position: requested postion
    /// - Returns: CellIdentificable view model
    func viewModelFor(_ index: Int) -> CellIdentificableViewModel?
    
    /// Tells element selected
    ///
    /// - Parameter index: selected element index
    func didSelect(_ index: Int)
    
}
