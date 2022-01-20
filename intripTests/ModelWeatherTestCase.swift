//
//  ModelWeatherTestCase.swift
//  intripTests
//
//  Created by Gilles David on 12/01/2022.
//

import Foundation

import XCTest
@testable import intrip

class ModelWeatherTestCase: XCTestCase {
    
    public var modelWeather = ModelWeather.shared
    
    func testUpdateweatherWhenDataIsOkResponseSuccess(){
        let modelWeather = ModelWeather(download: FakeDownload(witchCase: .success))
        modelWeather.updateWeather { responseWeather in
            switch responseWeather {
            case .Success:
                XCTAssert(true)
            case .Failure(_):
                XCTAssert(false)
            }
        }
    }
    
    func testUpdateweatherWhenDataIsKO(){
        let modelWeather = ModelWeather(download: FakeDownload(witchCase: .failure))
        modelWeather.updateWeather { responseWeather in
            switch responseWeather {
            case .Success:
                XCTAssert(false)
            case .Failure(_):
                XCTAssert(true)
            }
        }
    }
    
    
}
