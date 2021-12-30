//
//  Currencies.swift
//  intrip
//
//  Created by Gilles David on 28/12/2021.
//

import Foundation

struct Currencies {
    
    init() {
        names = []
        values = []
    }
    
    public var names: [String]
    public var values: [Double]
    
    public mutating func initWithDict(_ dict: Dictionary<String, Double>) {
        reset()
        for (key, value) in dict {
            names.append(key)
            values.append(value)
        }
    }
    private mutating func reset() {
        names = []
        values = []
    }
    
    public func getRatio(_ nameExchangeIn: String, _ nameExchangeOut: String) -> Double{
        
        let posIn = getPosOfNameExchange(nameExchange: nameExchangeIn)
        if posIn >= 0 {
            let posOut = getPosOfNameExchange(nameExchange: nameExchangeOut)
            if posOut >= 0 {
                // values are good
                return values[posOut] / values[posIn]
            } else {
                return 0.0
            }
        } else {
            return 0.0
        }
    }
    
    public func getRatio(_ nbExchangeIn: Int, _ nbExchangeOut: Int) -> Double {
        return values[nbExchangeOut] / values[nbExchangeIn]
    }
    private func getCurrentExchange(_ positionInListOfValues: Int) -> Double {
        return values[positionInListOfValues]
    }
    public func getPosOfNameExchange(nameExchange: String) -> Int {
        if let pos = names.enumerated().first(where: {$0.element.lowercased() == nameExchange.lowercased()}) {
            return pos.offset
        } else {
           return -1
        }
    }
}
