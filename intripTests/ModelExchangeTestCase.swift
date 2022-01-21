//
//  ModelExchangeTestCase.swift
//  intripTests
//
//  Created by Gilles David on 12/01/2022.
//

import Foundation

import XCTest
@testable import intrip

class ModelExchangeTestCase: XCTestCase {
    
    func testGetLastValuesWhenWhithFiledataAndNoTodayShouldOldValues(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake(), download: FakeDownload(witchCase: .failure), oneFileManager: OneFileManagerFake(fileExist: .Yes, today: .No))
        modelExchange.getLastValues { response in
            switch response {
            case .Success:
                XCTExpectFailure()
            case .Failure(failure: _):
                XCTExpectFailure()
            case .OldValues(date: _):
                XCTAssert(true)
            }
        }
    }
    
    func testGetLastValuesWhenWhithFiledataAndNoTodaySuccess(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake(), download: FakeDownload(witchCase: .success), oneFileManager: OneFileManagerFake(fileExist: .Yes, today: .No))
        modelExchange.getLastValues { response in
            switch response {
            case .Success:
                XCTAssert(true)
            case .Failure(failure: _):
                XCTExpectFailure()
            case .OldValues(date: _):
                XCTExpectFailure()
            }
        }
    }
    
    func testGetLastValuesWhenWhithFiledataAndTodayShouldSuccess(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake(), download: FakeDownload(witchCase: .success), oneFileManager: OneFileManagerFake(fileExist: .Yes, today: .Yes))
        modelExchange.getLastValues { response in
            switch response {
            case .Success:
                XCTAssert(true)
            case .Failure(failure: _):
                XCTExpectFailure()
            case .OldValues(date: _):
                XCTExpectFailure()
            }
        }
    }
    
    func testGetLastValuesWhenNoFiledataAndDownloadSuccess(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake(), download: FakeDownload(witchCase: .success), oneFileManager: OneFileManagerFake(fileExist: .No, today: .Yes))
        modelExchange.getLastValues { response in
            switch response {
            case .Success:
                XCTAssert(true)
            case .Failure(failure: _):
                XCTExpectFailure()
            case .OldValues(date: _):
                XCTExpectFailure()
            }
        }
    }
    
    func testGetLastValuesWhenNoFiledataAndDownloadFailure(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake(), download: FakeDownload(witchCase: .failure), oneFileManager: OneFileManagerFake(fileExist: .No, today: .Yes))
        modelExchange.getLastValues { response in
            switch response {
            case .Success:
                XCTExpectFailure()
            case .Failure(failure: _):
                XCTAssert(true)
            case .OldValues(date: _):
                XCTExpectFailure()
            }
        }
    }
    
    
    
    func testMoneyinofrangeWhenDataInisinvalidShouldreturnZero(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake())
        let (valueMoneyIn, valueMoneyOut) = modelExchange.moneyInChange(valTxtIn: "45d", currencyIn: 2, currencyOut: 4)
        XCTAssertEqual(valueMoneyIn, "0")
        XCTAssertEqual(valueMoneyOut, "0")
    }
    func testmoneyOutChangeWhenDataOutisinvalidShouldreturnZero(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake())
        let (valueMoneyIn, valueMoneyOut) = modelExchange.moneyOutChange(valTxtOut: "Abc", currencyOut: 2, currencyIn: 4)
        XCTAssertEqual(valueMoneyIn, "0")
        XCTAssertEqual(valueMoneyOut, "0")
    }
    func testmoneyInChangeWhenDataInIs3ratioIs2ShouldGet6Double(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake.init(name1: "a", value1: 2.0, name2: "b", value2: 4.0, ratio: 2.0))
        let (valueMoneyIn, valueMoneyOut) = modelExchange.moneyInChange(valTxtIn: "3", currencyIn: 1, currencyOut: 1)
        XCTAssertEqual(valueMoneyIn, "3")
        XCTAssertEqual(valueMoneyOut, "6.0")
    }
    func testmoneyOutChangeWhenDataOutIs4ratioIs4ShouldGet1Double(){
        let modelExchange = ModelExchange(currencyFake: CurrencyFake.init(name1: "a", value1: 2.0, name2: "b", value2: 4.0, ratio: 4))
        let (valueMoneyIn, valueMoneyOut) = modelExchange.moneyOutChange(valTxtOut: "4", currencyOut: 5, currencyIn: 2)
        XCTAssertEqual(valueMoneyOut, "4")
        XCTAssertEqual(valueMoneyIn, "1.0")
    }
    
}
