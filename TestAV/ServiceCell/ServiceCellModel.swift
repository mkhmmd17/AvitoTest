//
//  ServiceCellModel.swift
//  TestAV
//
//  Created by muslim on 15.01.2021.
//

import Foundation

final class ServiceCellModel {
    
    internal init(serviceImageURL: URL?,
                  serviceTitle: String,
                  serviceText: String,
                  servicePrice: String,
                  isSelected: Bool) {
        self.serviceImageURL = serviceImageURL
        self.serviceTitle = serviceTitle
        self.serviceText = serviceText
        self.servicePrice = servicePrice
        self.isSelected = isSelected
    }
    
    let serviceImageURL: URL?
    let serviceTitle: String
    let serviceText: String
    let servicePrice: String
    var isSelected: Bool
}
