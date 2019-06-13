//
//  StationTableViewCell.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    var viewModel: StationCellViewModel? {
        didSet {
            loadInfo()
        }
    }
    
    func loadInfo() {
        textLabel?.text = viewModel?.title
        detailTextLabel?.text = viewModel?.code
    }
    
    override func prepareForReuse() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }

}

extension StationTableViewCell: ConfigurableCell {
    
    func setup(using viewModel: CellIdentificableViewModel) {
        guard let viewModel = viewModel as? StationCellViewModel else {
            return
        }
        self.viewModel = viewModel
    }
}
