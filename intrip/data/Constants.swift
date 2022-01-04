//
//  Constants.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

struct Constants {
    
    // Exchange with Fixer
    public static let urlApiFixer = "http://data.fixer.io/api/latest?access_key={APIkey}&format=1&base=EUR"
    public static let fileNameExchangeFixer = "Fixer.plist"
    public static let APIkeyPattern = "{APIkey}"
    public static let formatDateFixer = "yyyy-MM-dd"
    public static let exchangeStrDefaultIn = "EUR"
    public static let exchangeStrDefaultOut = "USD"
    
    // Translate
    public static let urlApiDeepl = ""
  
    // Weather
    public static let urlApiOpenweathermap = "https://api.openweathermap.org/data/2.5/onecall?lat={Lat}&lon={Lon}&exclude=hourly,daily&appid={APIkey}&units=metric&lang=fr"
    public static let latOpenweathermapPattern = "{Lat}"
    public static let lonOpenweathermapPattern = "{Lon}"
    
    public static let idParis = 6455259
    public static let latParis = "48.856461"
    public static let lonParis = "2.35236"
    public static let cityNameParis = "Paris, fr"
    
    public static let latNewYork = "40.714272"
    public static let lonNewYork = "-74.005966"
    public static let cityNameNewYork = "New York City, us"
    public static let idNewYork = 5128581
    
}
