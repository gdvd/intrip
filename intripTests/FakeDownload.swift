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
        super.init(session: URLSession())
    }
    
    
    enum WitchCase {
        case success
        case failure
    }
    var isCase: WitchCase!
    
    convenience init(witchCase: WitchCase) {
        self.init()
        isCase = witchCase
    }
    
    override func downloadTranslate(textToTranslate: String, langIn: String, langOut: String, autoDetect: Bool, completionHandler: @escaping (Networkresponse<ResponseDeeplData>) -> Void) {
        switch isCase {
        case .success:
            let responseDeeplData = ResponseDeeplData(detected_source_language: "FR", text: "Bonjour")
            completionHandler(Networkresponse.Success(response: responseDeeplData))
        case .failure:
            completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
        case .none:
            fatalError()
        }
    }
    
    override func downloadRatesWithFixer(completionHandler: @escaping (Networkresponse<ItemFixer>) -> Void) {
        switch isCase {
        case .success:
            let rates = ["": 1.0]
            let itemFixer = ItemFixer(success: true, timestamp: 1, base: "", date: "", rates: rates)
            completionHandler(Networkresponse.Success(response: itemFixer))
        case .failure:
            completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
        case .none:
            fatalError()
        }
    }

    override func downloadWeatherData(lon: String, lat: String, completionHandler: @escaping (Networkresponse<OpenWeatherMap>) -> Void) {
        
        switch isCase {
        case .success:
            let weather = Weather(id: 0, main: "main", description: "description", icon: "icon")
            let current = Current(dt: 0.0, sunrise: 0.0, sunset: 0.0, temp: 0.0, feels_like: 0.0, pressure: 0.0, humidity: 0, dew_point: 0.0, uvi: 0.0, clouds: 0.0, visibility: 0.0, wind_speed: 0.0, wind_deg: 0.0, weather: [weather])
            let openweathermap = OpenWeatherMap(lat: 0.0, lon: 0.0, timezone: "timezone", timezone_offset: 0, current: current)
            completionHandler(Networkresponse.Success(response: openweathermap))
        case .failure:
            completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
        case .none:
            fatalError()
        }
        
        
    }
    
}
