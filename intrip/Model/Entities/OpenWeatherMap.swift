//
//  OpenWeatherMap.swift
//  intrip
//
//  Created by Gilles David on 04/01/2022.
//

import Foundation

struct OpenWeatherMap: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: Current
//    let minutely: [MinutelyItem]
}
struct Current: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let weather: [Weather]
}
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
//struct MinutelyItem: Codable {
//    let dt: Double
//    let precipitation: Double
//}
