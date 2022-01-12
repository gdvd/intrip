//
//  Constants.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

enum Constants {
    
    // Exchange with Fixer
    static let urlApiFixer = "http://data.fixer.io/api/latest?access_key=\(ApiKeys.keyFixer)&format=1&base=EUR"
    static let fileNameExchangeFixer = "Fixer.plist"
    static let formatDateFixer = "yyyy-MM-dd"
    static let exchangeStrDefaultIn = "EUR"
    static let exchangeStrDefaultOut = "USD"
    
    // Translate
    static let urlApiDeepl = "https://api-free.deepl.com/v2/translate?auth_key=\(ApiKeys.keyDeepl)&text={textToTranslate}&target_lang="
    static let optionSourceLang = "&source_lang="
    static let textToTranslatePattern = "{textToTranslate}"
    
    // Weather
    static let urlApiOpenweathermap = "https://api.openweathermap.org/data/2.5/onecall?lat={Lat}&lon={Lon}&exclude=hourly,daily&appid=\(ApiKeys.keyOpenWeather)&units=metric&lang=fr"
    static let latOpenweathermapPattern = "{Lat}"
    static let lonOpenweathermapPattern = "{Lon}"
    
    static let idParis = 6455259
    static let latParis = "48.856461"
    static let lonParis = "2.35236"
    static let cityNameParis = "Paris, fr"
    
    static let latNewYork = "40.714272"
    static let lonNewYork = "-74.005966"
    static let cityNameNewYork = "New York City, us"
    static let idNewYork = 5128581
    
}
