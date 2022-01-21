//
//  Currencies.swift
//  intrip
//
//  Created by Gilles David on 28/12/2021.
//

import Foundation

class Currencies {
    
    init() {
        names = []
        values = []
    }
    
    public var names: [String]
    public var values: [Double]
    
    public func initWithDictAndSort(_ dict: Dictionary<String, Double>) {
        reset()
        let sortedArray = dict.sorted( by: { $0.0 < $1.0 })
        for (key, value) in sortedArray {
            names.append(key)
            values.append(value)
        }
    }
    
    private func reset() {
        names = []
        values = []
    }
    
    public func getRatio(_ nbExchangeIn: Int, _ nbExchangeOut: Int) -> Double {
        return values[nbExchangeOut] / values[nbExchangeIn]
    }
    
    public func getCurrentExchange(_ positionInListOfValues: Int) -> Double {
        return values[positionInListOfValues]
    }
    
    public func getPosOfNameExchange(nameExchange: String) -> Int {
        if let pos = names.enumerated().first(where: {$0.element.lowercased() == nameExchange.lowercased()}) {
            return pos.offset
        } else {
            if names.count > 0 {
                // Names exist but not with 'nameExchange' -> return first
                return 1
            } else {
                // Names doesnt exist -> return -1
                return -1
            }
        }
    }
}
