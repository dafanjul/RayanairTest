//
//  AirportListViewController.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class StationListViewController: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties

    var viewModel: StationListViewModelType? {
        didSet {
            viewModel?.didUpdate = { [weak self] in
                self?.tableView.isHidden = false
                self?.messageView.isHidden = true
                self?.reloadTableView()
            }
            viewModel?.displayMessage = { [weak self] message in
                self?.tableView.isHidden = true
                self?.messageView.isHidden = false
                self?.messageLabel.text = message
            }
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel?.tableDataSource
        tableView.delegate = viewModel?.tableDataSource
        title = viewModel?.title
        setupSearchController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel?.didFinish()
        }
    }
    
    // MARK: - Helpers
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Stations"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension StationListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            viewModel?.filterContentForSearchText(searchText)
        }
    }
}

extension StationListViewController: SearchFilterStatusProvider {
    
    var isFilterActive: Bool {
        return searchController.isActive && searchController.searchBar.text?.isEmpty == false
    }
    
}
