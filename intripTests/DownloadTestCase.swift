//
//  DownloadTestCase.swift
//  intripTests
//
//  Created by Gilles David on 26/12/2021.
//

import XCTest
@testable import intrip

class DownloadTestCase: XCTestCase {
    
    func testDownloadratesWithFixerShouldPostFailedCallbackIfError(){
        // Given
        let download = Download(
            session:URLSessionFake(data: nil, 
                                   response: nil,
                                   error: FakeResponseDataFixer.errorDownload))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        download.downloadRatesWithFixer { itemFixer in
            // Then
            XCTAssertNil(itemFixer)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
