//
//  SaveInUserDefault.swift
//  intrip
//
//  Created by Gilles David on 18/01/2022.
//

import Foundation

struct SaveInUserDefault {
    private struct Keys {
        static let currencyIn = "currencyIn"
        static let currencyout = "currencyOut"
    }
    static var currencyIn: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currencyIn) ?? Constants.exchangeStrDefaultIn
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyIn)
        }
    }
    
    static var currencyOut: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currencyout) ?? Constants.exchangeStrDefaultOut
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyout)
        }
    }
}
