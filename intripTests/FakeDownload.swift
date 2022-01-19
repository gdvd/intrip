//
//  FakeDownload.swift
//  intripTests
//
//  Created by Gilles David on 19/01/2022.
//

import Foundation

@testable import intrip

class FakeDownload: Download {
    
    init() {
        super.init()
    }
    
    override func downloadWeatherData(lon: String, lat: String, completionHandler: @escaping (Networkresponse<OpenWeatherMap>) -> Void) {
        completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
    }
    
}
