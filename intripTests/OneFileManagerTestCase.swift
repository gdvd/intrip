//
//  OneFileManagerTestCase.swift
//  intripTests
//
//  Created by Gilles David on 07/01/2022.
//

import XCTest
@testable import intrip

class OneFileManagerTestCase: XCTestCase {

    func testIfFileDoesntExist(){
        //Given
        //When
        //Then
        XCTAssertFalse(OneFileManager.ifFileExist(fileName: "nothing"))
    }

    func testFileDoesntExisteThenCreateIt(){
        
        //Given
        var itemToSave:ItemFixer!
        let bundle = Bundle(for: OneFileManagerTestCase.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")
        
        
        if let data = try? Data(contentsOf: url!) {
            guard let responseJSON = try? JSONDecoder().decode(ItemFixer.self, from: data) else{
                return
            }
            itemToSave = responseJSON
        }
        
        // ItemFixer is loaded ?
        XCTAssertEqual(itemToSave.date, "2022-01-07")
        
        //When
        // test saveChecklistItemsFixer(fileName: String, itemToSave:ItemFixer)
        OneFileManager.saveChecklistItemsFixer(fileName: "nothing", itemToSave: itemToSave)
        XCTAssert(OneFileManager.ifFileExist(fileName: "nothing"))
                
        //Then
        // Test loadItemsFixer(fileName: String) -> ItemFixer
        let itemFixerOnDisk = OneFileManager.loadItemsFixer(fileName:"nothing")
        XCTAssertEqual(itemFixerOnDisk.base, "EUR")
        XCTAssertEqual(itemFixerOnDisk.success, true)
        XCTAssertEqual(itemFixerOnDisk.date, "2022-01-07")
        
        let file = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask)[0].path + "/nothing"
        do {
             let fileManager = FileManager.default
            if OneFileManager.ifFileExist(fileName:"nothing") {
                try fileManager.removeItem(atPath: file)
            } else {
                XCTAssert(false)
            }
        }
        catch {
            XCTAssert(false)
        }
        XCTAssert(true)
        
        
    }
    
}
