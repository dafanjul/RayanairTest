//
//  FlightListViewController.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class FlightListViewController: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    var viewModel: FlightListViewModelType? {
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
    
    // MARK: - Life cycle
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel?.didFinish()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel?.tableDataSource
        tableView.delegate = viewModel?.tableDataSource
        title = viewModel?.title
    }
    
    // MARK: - Helpers
    
    private func setupViewModel() {
        if tableView != nil {
            tableView.dataSource = viewModel?.tableDataSource
            tableView.delegate = viewModel?.tableDataSource
        }
        viewModel?.didUpdate = { [weak self] in
            self?.reloadTableView()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
}
