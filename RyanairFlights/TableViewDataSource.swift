//
//  TableViewDataSource.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

import UIKit

final class TableViewDataSource: NSObject {
    
    private var dataProvider: ListDataProvider
        
    init(dataProvider: ListDataProvider) {
        self.dataProvider = dataProvider
    }
}

extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = dataProvider.viewModelFor(indexPath.row) else {
            fatalError()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        
        if let cell = cell as? ConfigurableCell {
            cell.setup(using: cellViewModel)
        }
        
        return cell
    }
    
}

extension TableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataProvider.didSelect(indexPath.row)
    }
}

