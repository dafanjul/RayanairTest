//
//  InputParametersType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// A type that can receive input parameters
protocol InputParametersViewType: AnyObject {
    
    /// `InputParametersViewModelType` view model to set
    var viewModel: InputParametersViewModelType? { get set }
    
}

