//
//  ListType.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 15/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

/// Elements that can be filtered should conform this protocol
protocol Filtrable {
    /// Search text is contained
    ///
    /// - Parameter text: text to search
    /// - Returns: true if the element contains the provided text
    func contains(_ text: String) -> Bool
}

/// Type that provides with information related to Search Filter status
protocol SearchFilterStatusProvider: AnyObject {
    
    /// Returns true whether the filter is currently active
    var isFilterActive: Bool { get }
    
}

class ListType<T> {
    
    fileprivate var elements = [T]()
    
    var numberOfElements: Int {
        return elements.count
    }
    
    func setList(_ list: [T]) {
        elements = list
    }
    
    func element(at index: Int) -> T {
        return elements[index]
    }
    
}

class FiltrableListType<T: Filtrable>: ListType<T> {
    var isFilterActive: Bool {
        return filterStatusProvider?.isFilterActive ?? false
    }
    weak var filterStatusProvider: SearchFilterStatusProvider?
    
    override var elements: [T] {
        get {
            return isFilterActive ? filteredElements : super.elements
        }
        set {
            super.elements = newValue
        }
    }
    private var filteredElements = [T]()
    
    func filterContentForSearchText(_ text: String, completion: @escaping (() -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.filteredElements = super.elements.filter{ $0.contains(text) }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
