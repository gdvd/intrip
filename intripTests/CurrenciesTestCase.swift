//
//  CurrenciesTestCase.swift
//  intripTests
//
//  Created by Gilles David on 07/01/2022.
//
import XCTest
@testable import intrip

class CurrenciesTestCase: XCTestCase {

    func testGetPosOfNameExchangeGivenArgInNamesArrayAndNameExchangeDoesntExistShouldBeOne() {
        let currency = Currencies()
        currency.names = ["OneStringInName"]
        let res = currency.getPosOfNameExchange(nameExchange: "NoNameExist")
        XCTAssertEqual(res, 1)
    }
    
    func testGetPosOfNameExchangeGivenNoArgInNamesArrayAndNameExchangeDoesntExistShouldBeOne() {
        let currency = Currencies()
        let res = currency.getPosOfNameExchange(nameExchange: "NoNameExist")
        XCTAssertEqual(res, -1)
    }
    
    func testInitGivenNamesAndValuesEmpty() {
        
        //Given
        var itemToSave: ItemFixer!
        let bundle = Bundle(for: CurrenciesTestCase.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")
        
        
        if let data = try? Data(contentsOf: url!) {
            guard let responseJSON = try? JSONDecoder().decode(ItemFixer.self, from: data) else{
                return
            }
            itemToSave = responseJSON
        }
        
        // ItemFixer is loaded ?
        XCTAssertEqual(itemToSave.date, "2022-01-07")
        
        let currency = Currencies()
        currency.initWithDictAndSort(itemToSave.rates)
        XCTAssertTrue(currency.names.count > 0)
        XCTAssertEqual(currency.names.count, currency.values.count)
        
        let posEur = currency.getPosOfNameExchange(nameExchange: "EUR")
        let posUsd = currency.getPosOfNameExchange(nameExchange: "USD")
        let ratio = currency.getCurrentExchange(posUsd)/currency.getCurrentExchange(posEur)
        XCTAssertEqual(ratio, currency.getRatio(posEur, posUsd))
        
    }

}
