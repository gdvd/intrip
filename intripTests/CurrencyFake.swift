//
//  CurrencyFake.swift
//  intripTests
//
//  Created by Gilles David on 20/01/2022.
//

import Foundation
@testable import intrip

class CurrencyFake: Currencies {
    
    private var ratio: Double!
    
    override func getRatio(_ nbExchangeIn: Int, _ nbExchangeOut: Int) -> Double {
        return ratio
    }
    
    override init(){
        super.init()
        self.ratio = 1.0
    }
    
    init(name1: String, value1: Double, name2: String, value2: Double, ratio: Double) {
        super.init()
        names.append(contentsOf: [name1, name2])
        values.append(contentsOf: [value1, value2])
        self.ratio = ratio
    }

}
