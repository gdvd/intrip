//
//  ModelTranslateTestCase.swift
//  intripTests
//
//  Created by Gilles David on 12/01/2022.
//

import Foundation

import XCTest
@testable import intrip

class ModelTranslateTestCase: XCTestCase {
    
    func testGetTranslateSentenceShouldbeOK(){
        let modelTranslate = ModelTranslate(download: FakeDownload(witchCase: .success))
        modelTranslate.getTranslateSentence(textToTranslate: "", langIn: "", langOut: "", autoDetect: false) { responseDeepl in
            switch responseDeepl {
            case .Success(response: _):
                XCTAssert(true)
            case .Failure(failure: _):
                XCTExpectFailure()
            }
        }
    }
    
    func testGetTranslateSentenceNetworkFailedShouldbeKO(){
        let modelTranslate = ModelTranslate(download: FakeDownload(witchCase: .failure))
        modelTranslate.getTranslateSentence(textToTranslate: "", langIn: "", langOut: "", autoDetect: false) { responseDeepl in
            switch responseDeepl {
            case .Success(response: _):
                XCTExpectFailure()
            case .Failure(failure: _):
                XCTAssert(true)
            }
        }
    }
    func testGetCodeInLanguageGiven9thPositionShouldBeCodeFR(){
        let translate = ModelTranslate.shared
        let lang = translate.getCodeInLanguage(pos: 9)
        XCTAssertEqual(lang, "FR")
    }
    func testGetCodeInLanguageGiven99thPositionShouldBeCodeNothing(){
        let translate = ModelTranslate.shared
        let lang = translate.getCodeInLanguage(pos: 99)
        XCTAssertEqual(lang, "")
    }
    
    func testGetLangInLanguageGiven99thPositionShouldBeNothing(){
        let translate = ModelTranslate.shared
        let lang = translate.getLangInLanguage(pos: 99)
        XCTAssertEqual(lang, "")
    }
    
    func testGetLangInLanguageGiven9thPositionShouldBeFrench(){
        let translate = ModelTranslate.shared
        let lang = translate.getLangInLanguage(pos: 9)
        XCTAssertEqual(lang, "French")
    }
    
    func testGetPosInLanguageWhenRRDoesntExistPositionShouldBeNeg1(){
        let translate = ModelTranslate.shared
        let pos = translate.getPosInLanguage(lan: "RR")
        XCTAssertEqual(pos, -1)
    }
    
    func testGetPosInLanguageWhenFrIs9thPositionShouldBe9(){
        let translate = ModelTranslate.shared
        let pos = translate.getPosInLanguage(lan: "FR")
        XCTAssertEqual(pos, 9)
    }
    
    func testGetPosInLanguageWhenFrIs9thPositionShouldBeNot8(){
        let translate = ModelTranslate.shared
        let pos = translate.getPosInLanguage(lan: "FR")
        XCTAssertNotEqual(pos, 8)
    }
    
}
