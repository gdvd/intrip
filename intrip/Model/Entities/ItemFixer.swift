//
//  ItemFixer.swift
//  intrip
//
//  Created by Gilles David on 22/12/2021.
//

import Foundation

struct ItemFixer: Codable {
    init(success: Bool,timestamp: Double,base: String, date : String, rates: Dictionary<String, Double> ){
        self.success = success
        self.timestamp = timestamp
        self.base = base
        self.date = date
        self.rates = rates
    }
    var success: Bool
    var timestamp: Double
    var base: String
    var date: String
    var rates: Dictionary<String, Double>
}

