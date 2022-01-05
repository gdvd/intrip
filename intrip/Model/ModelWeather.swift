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
    
    public var weatherCities: [WeatherCity] = []
    
    private func cityOne() -> WeatherCity {
        return WeatherCity(id: Constants.idNewYork, lon: Constants.lonNewYork, lat: Constants.latNewYork, cityName: Constants.cityNameNewYork)
    }
    private func cityTwo() -> WeatherCity {
        return WeatherCity(id: Constants.idParis, lon: Constants.lonParis, lat: Constants.latParis, cityName: Constants.cityNameParis)
    }
    
    public func updateWeather(callBack: @escaping(ResponseWeather) -> Void){
        
        Download.shared.downloadWeatherData(lon: weatherCities[0].lon, lat: weatherCities[0].lat) { result in
            switch result {
            case .Success(response: let resp0):
                self.weatherCities[0].weather = resp0
                
                Download.shared.downloadWeatherData(lon: self.weatherCities[1].lon, lat: self.weatherCities[1].lat) { result in
                    switch result {
                    case .Success(response: let resp1):
                        print(resp1.current.weather.description)
                        self.weatherCities[1].weather = resp1
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
