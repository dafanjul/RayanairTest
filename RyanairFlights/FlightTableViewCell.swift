//
//  FlightTableViewCell.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var fareDescriptionLabel: UILabel!
    
    var viewModel: FlightCellViewModel? {
        didSet {
            loadInfo()
        }
    }
    
    func loadInfo() {
        flightNumberLabel.text = viewModel?.flightNumber
        departureDateLabel.text = viewModel?.date
        fareDescriptionLabel.text = viewModel?.fareDescription
    }

    override func prepareForReuse() {
        flightNumberLabel.text = nil
        departureDateLabel.text = nil
        fareDescriptionLabel.text = nil
    }
    
}

extension FlightTableViewCell: ConfigurableCell {
    
    func setup(using viewModel: CellIdentificableViewModel) {
        guard let viewModel = viewModel as? FlightCellViewModel else {
            return
        }
        self.viewModel = viewModel
    }
}
