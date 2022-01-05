//
//  WeatherCity.swift
//  intrip
//
//  Created by Gilles David on 04/01/2022.
//

import Foundation

struct WeatherCity {
    init(id: Int, lon: String, lat: String, cityName: String) {
        self.id = id
        self.lon = lon
        self.lat = lat
        self.cityName = cityName
    }
    public let id: Int!
    public let lon: String!
    public let lat: String!
    public let cityName: String!
    
    public var weather: OpenWeatherMap?
}
