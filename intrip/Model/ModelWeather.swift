//
//  ModelWeather.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

enum ResponseWeather {
    case Success
    case Failure(failure: String)
}

class ModelWeather {
    
    public static let shared = ModelWeather()
    private init() {
        weatherCities.append(contentsOf: [cityOne(), cityTwo()])
    }
    
    // 4 XCTest
    private var download = Download.shared
    init(download: Download){
        self.download = download
        weatherCities.append(contentsOf: [cityOne(), cityTwo()])
    }
    
    public var weatherCities: [WeatherCity] = []
    
    private func cityOne() -> WeatherCity {
        return WeatherCity(id: Constants.idNewYork, lon: Constants.lonNewYork, lat: Constants.latNewYork, cityName: Constants.cityNameNewYork)
    }
    private func cityTwo() -> WeatherCity {
        return WeatherCity(id: Constants.idParis, lon: Constants.lonParis, lat: Constants.latParis, cityName: Constants.cityNameParis)
    }
    
    public func updateWeather(callBack: @escaping(ResponseWeather) -> Void){
        
        download.downloadWeatherData(lon: weatherCities[0].lon, lat: weatherCities[0].lat) { result in
            switch result {
            case .Success(response: let respon):
                self.weatherCities[0].weather = respon
                
                self.download.downloadWeatherData(lon: self.weatherCities[1].lon, lat: self.weatherCities[1].lat) { result in
                    switch result {
                    case .Success(response: let resp):
                        self.weatherCities[1].weather = resp
                        callBack(.Success)
                    case .Failure(failure: let error):
                        print(error.localizedDescription)
                        callBack(.Failure(failure: error.localizedDescription))
                    }
                }
                
            case .Failure(failure: let error):
                print(error.localizedDescription)
                callBack(.Failure(failure: error.localizedDescription))
            }
        }
    }
}
