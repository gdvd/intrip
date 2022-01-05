//
//  DownloadTestCase.swift
//  intripTests
//
//  Created by Gilles David on 26/12/2021.
//

import XCTest
@testable import intrip

class DownloadTestCase: XCTestCase {
    
        func testDownloadratesWithFixerShouldGetFailedCallbackIfError(){
            // Given
            let download = Download(
                session:URLSessionFake(data: nil, 
                                       response: nil,
                                       error: FakeResponseDataFixer.DownloadError.init()))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            download.downloadRatesWithFixer { networkresp in
                // Then
                switch networkresp {
                case .Success:
                    XCTAssert(false)
                case .Failure:
                    XCTAssert(true)
                }
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }


    
}
