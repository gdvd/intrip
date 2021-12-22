//
//  ItemFixer.swift
//  intrip
//
//  Created by Gilles David on 22/12/2021.
//

import Foundation

class ItemFixer: NSObject, Codable {
    init(success: Bool,timestamp: Int,base: String, date : String, rates: [Money] ){
        self.success = success
        self.timestamp = timestamp
        self.base = base
        self.date = date
        self.rates = rates
    }
    var success: Bool
    var timestamp: Int
    var base: String
    var date: String
    var rates: [Money]
}

class Money: NSObject, Codable {
    init(_ name: String,_ value: Double){
        self.name = name
        self.value = value
    }
    var name: String
    var value: Double
}
