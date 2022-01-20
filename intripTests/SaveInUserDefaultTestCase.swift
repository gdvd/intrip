//
//  SaveInUserDefaultTestCase.swift
//  intripTests
//
//  Created by Gilles David on 20/01/2022.
//

import XCTest
@testable import intrip

class SaveInUserDefaultTestCase: XCTestCase {

    func testSaveInUserDefaultCurInWhenWriteDataWhouldGetSame(){
        let dataSave = SaveInUserDefault.currencyIn
        let curIn = "testIn"
        SaveInUserDefault.currencyIn = curIn
        XCTAssertEqual(curIn, SaveInUserDefault.currencyIn)
        SaveInUserDefault.currencyIn = dataSave
    }
    func testSaveInUserDefaultCurOutWhenWriteDataWhouldGetSame(){
        let dataSave = SaveInUserDefault.currencyOut
        let curOut = "testOut"
        SaveInUserDefault.currencyOut = curOut
        XCTAssertEqual(curOut, SaveInUserDefault.currencyOut)
        SaveInUserDefault.currencyOut = dataSave
    }
    

}
