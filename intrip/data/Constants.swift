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
    public static let formatDateFixer = "yyyy-MM-dd"
    
    // Translate
    public static let urlApiDeepl = ""
  
    // Weather
    public static let urlApiOpenweathermap = "api.openweathermap.org/data/2.5/weather?q={city name}&appid={APIkey}"
    
}
