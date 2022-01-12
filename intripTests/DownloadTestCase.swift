//
//  DownloadTestCase.swift
//  intripTests
//
//  Created by Gilles David on 26/12/2021.
//

//FakeResponseDataFixer.DownloadError.init()

import XCTest
@testable import intrip

class DownloadTestCase: XCTestCase {
    
    //MARK: - Translate
    func testDownloadtranslateWithTranslateShouldGetSuccessCallbackIfNoErrorAndCorrectData(){
        //Given
        //When
        //Then
    }
    func testDownloadtranslateWithTranslateShouldGetFailureCallbackIfDataNil(){
        //Given
        //When
        //Then
    }
    func testDownloadtranslateWithTranslateShouldGetFailureCallbackIfError(){
        //Given
        //When
        //Then
    }
    func testDownloadtranslateWithTranslateShouldGetFailureCallbackIfResponseKO(){
        //Given
        //When
        //Then
    }
    func testDownloadranslateWithTranslateShouldGetFailureCallbackIfIncorrectData(){
        //Given
        //When
        //Then
    }
    
    //MARK: - Weather
    func testDownloadweatherWithWeatherShouldGetSuccessCallbackIfNoErrorAndCorrectData(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataWeather.downloadCorrectDataWeather, 
                                   response: FakeResponseDataWeather.responseOK,
                                   error: nil))
        // When
        let lati = 40.7143
        let long = -74.006
        let timezone_off = -18000
        
        download.downloadWeatherData(lon: lati.description, lat: long.description) { networkresp in
            // Then
            switch networkresp {
            case .Success(let responseJSON):
                XCTAssertEqual(lati, responseJSON.lat)
                XCTAssertEqual(long, responseJSON.lon)
                XCTAssertEqual(timezone_off, responseJSON.timezone_offset)
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(false)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadweatherWithWeatherShouldGetFailureCallbackIfDataNil(){
        // Given
        let download = Download(
            session:URLSessionFake(data: nil, 
                                   response: FakeResponseDataWeather.responseOK,
                                   error: nil))
        // When
        let lati = 40.7143
        let long = -74.006
        download.downloadWeatherData(lon: lati.description, lat: long.description) { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)            
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(true)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadweatherWithWeatherShouldGetFailureCallbackIfError(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataWeather.downloadCorrectDataWeather, 
                                   response: FakeResponseDataWeather.responseOK,
                                   error: FakeResponseDataWeather.DownloadError.init()))
        // When
        let lati = 40.7143
        let long = -74.006
        download.downloadWeatherData(lon: lati.description, lat: long.description) { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)            
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(true)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    
    func testDownloadweatherWithWeatherShouldGetFailureCallbackIfResponseKO(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataWeather.downloadCorrectDataWeather, 
                                   response: FakeResponseDataWeather.responseKO,
                                   error: nil))
        // When
        let lati = 40.7143
        let long = -74.006
        download.downloadWeatherData(lon: lati.description, lat: long.description) { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)            
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(false)
                case .statusCodeWrong:
                    XCTAssert(true)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadweatherWithWeatherShouldGetFailureCallbackIfIncorrectDataFixer(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataWeather.downloadIncorrectDataFixer, 
                                   response: FakeResponseDataWeather.responseOK,
                                   error: nil))
        // When
        let lati = 40.7143
        let long = -74.006
        download.downloadWeatherData(lon: lati.description, lat: long.description) { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)            
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(false)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(true)
                }
            }
        }
    }
    
    
    //MARK: - Fixer
    func testDownloadratesWithFixerShouldGetSuccessCallbackIfNoErrorAndCorrectData(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataFixer.downloadCorrectDataFixer, 
                                   response: FakeResponseDataFixer.responseOK,
                                   error: nil))
        // When
        let  succ = true
        let timest = 1640361243
        let base = "EUR"
        download.downloadRatesWithFixer { networkresp in
            // Then
            switch networkresp {
            case .Success(let responseJSON):
                XCTAssertEqual(succ, responseJSON.success)
                XCTAssertEqual(timest, responseJSON.timestamp)
                XCTAssertEqual(base, responseJSON.base)
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(false)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadratesWithFixerShouldGetFailedCallbackIfDataNil(){
        // Given
        let download = Download(
            session:URLSessionFake(data: nil, 
                                   response: FakeResponseDataFixer.responseOK,
                                   error: nil))
        // When
        download.downloadRatesWithFixer { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(true)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadratesWithFixerShouldGetFailedCallbackIfError(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataFixer.downloadCorrectDataFixer, 
                                   response: FakeResponseDataFixer.responseOK,
                                   error: FakeResponseDataFixer.DownloadError.init()))
        // When
        download.downloadRatesWithFixer { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(true)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadratesWithFixerShouldGetFailedCallbackIfResponseIncorrect(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataFixer.downloadCorrectDataFixer, 
                                   response: FakeResponseDataFixer.responseKO,
                                   error: nil))
        // When
        download.downloadRatesWithFixer { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(false)
                case .statusCodeWrong:
                    XCTAssert(true)
                case .decodeError:
                    XCTAssert(false)
                }
            }
        }
    }
    
    func testDownloadratesWithFixerShouldGetFailedCallbackIfDataIncorrect(){
        // Given
        let download = Download(
            session:URLSessionFake(data: FakeResponseDataFixer.downloadIncorrectDataFixer, 
                                   response: FakeResponseDataFixer.responseOK,
                                   error: nil))
        // When
        //        let expectation = XCTestExpectation(description: "Wait for queue change.")
        download.downloadRatesWithFixer { networkresp in
            // Then
            switch networkresp {
            case .Success(_):
                XCTAssert(false)
            case .Failure(let errorFailure):
                switch errorFailure {
                case .returnNil:
                    XCTAssert(false)
                case .statusCodeWrong:
                    XCTAssert(false)
                case .decodeError:
                    XCTAssert(true)
                }
            }
            //            expectation.fulfill()
        }
        //        wait(for: [expectation], timeout: 0.01)
    }
    
}
