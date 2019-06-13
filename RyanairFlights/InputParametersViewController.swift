//
//  InputParametersViewController.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 14/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import UIKit

class InputParametersViewController: UIViewController, Storyboarded, InputParametersViewType {
   
    // MARK: - Outlets
    
    @IBOutlet weak var originSearchButton: UIButton!
    @IBOutlet weak var destinationSearchButton: UIButton!
    @IBOutlet weak var adultsButton: UIButton!
    @IBOutlet weak var teensButton: UIButton!
    @IBOutlet weak var childrenButton: UIButton!
    @IBOutlet weak var originStationLabel: UILabel!
    @IBOutlet weak var destinationStationLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var teensLabel: UILabel!
    @IBOutlet weak var childrenLabel: UILabel!
    
    // MARK: - Properties
    
    private var pickerHandler: PickerHandler?
    private weak var pickerContainer: UIView?
    private weak var datePicker: UIDatePicker?
    
    var viewModel: InputParametersViewModelType? {
        didSet {
            viewModel?.didUpdate = { [weak self] in
                self?.loadData()
            }
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStationButtons()
        setupPassengerButtons()
        loadData()
    }

    // MARK: - Events
    
    @IBAction func searchPressed(_ sender: Any) {
        viewModel?.searchFlights()
    }
    
    @IBAction func selectStation(_ sender: UIButton) {
        guard let station = StationDirection(rawValue: sender.tag) else {
            return
        }
        if case StationDirection.origin = station {
            viewModel?.selectOriginStation()
        } else {
            viewModel?.selectDestinationStation()
        }
    }
    
    @IBAction func displayPassengerPicker(_ sender: UIButton) {
        guard let section = PickerSection(rawValue: sender.tag), let viewModel = viewModel else {
            return
        }
        switch section {
        case .adult:
            displayPassengerPicker(with: viewModel.adultsOptions, forSection: section)
        case .teen:
            displayPassengerPicker(with: viewModel.teensOptions, forSection: section)
        case .child:
            displayPassengerPicker(with: viewModel.childrenOptions, forSection: section)
        }
    }
    
    @IBAction func departureDatePressed(_ sender: UIButton) {
        displayDatePicker()
    }
    
    // MARK: - Helpers
    
    private func displayPassengerPicker(with options: [String], forSection section: PickerSection) {
        let pickerHandler = PickerHandler(options: options)
        self.pickerHandler = pickerHandler
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = pickerHandler
        let toolBar = createToolbar(forPassangers: true)
        pickerContainer = createContainerFor(picker: picker, toolBar: toolBar)
        pickerContainer?.tag = section.rawValue
    }
    
    private func displayDatePicker() {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker = picker
        let toolBar = createToolbar(forPassangers: false)
        pickerContainer = createContainerFor(picker: picker, toolBar: toolBar)
    }
    
    private func createContainerFor(picker: UIView, toolBar: UIView) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        container.addSubview(picker)
        container.addSubview(toolBar)
        addConstraints(toolBar, container, picker)
        pickerContainer = container
        
        return container
    }
    
    private func createToolbar(forPassangers isPassanger: Bool) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.sizeToFit()
        let action = isPassanger ? #selector(donePressedPassengers) : #selector(donePressedForDate)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPressed))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    private func loadData() {
        originStationLabel.text = viewModel?.originStationDescription
        destinationStationLabel.text = viewModel?.destinationStationDescription
        departureDateLabel.text = viewModel?.departureDateDescription
        adultsLabel.text = viewModel?.adultsCount
        teensLabel.text = viewModel?.teensCount
        childrenLabel.text = viewModel?.childrenCount
    }
    
    private func setupStationButtons() {
        originSearchButton.tag = StationDirection.origin.rawValue
        destinationSearchButton.tag = StationDirection.destination.rawValue
    }
    
    private func setupPassengerButtons() {
        adultsButton.tag = PickerSection.adult.rawValue
        teensButton.tag = PickerSection.teen.rawValue
        childrenButton.tag = PickerSection.child.rawValue
    }
    
    private func addConstraints(_ toolBar: UIView, _ container: UIView, _ picker: UIView) {
        toolBar.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: picker.topAnchor).isActive = true
        
        picker.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func donePressedPassengers() {
        defer {
            pickerContainer?.removeFromSuperview()
        }
        guard let selectedIndex = pickerHandler?.done(),
            let section = pickerContainer?.tag,
            let option = PickerSection(rawValue: section) else {
            return
        }
        
        switch option {
        case .adult:
            viewModel?.setAdultIndexOption(selectedIndex)
        case .child:
            viewModel?.setChildIndexOption(selectedIndex)
        case .teen:
            viewModel?.setTeenIndexOption(selectedIndex)
        }
    }
    
    @objc func donePressedForDate() {
        defer {
            pickerContainer?.removeFromSuperview()
        }
        guard let selectedDate = datePicker?.date else {
            return
        }
        viewModel?.setDepartureDate(selectedDate)
    }
    
    @objc func cancelPressed() {
        pickerContainer?.removeFromSuperview()
    }
    
}

extension InputParametersViewController {
    
    enum StationDirection: Int {
        case origin = 1
        case destination
    }
    
    enum PickerSection: Int {
        case adult = 1
        case teen
        case child
    }
    
}
