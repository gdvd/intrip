//
//  ResponseDeepl.swift
//  intrip
//
//  Created by Gilles David on 10/01/2022.
//

import Foundation

struct ResponseDeepl: Codable {
    init(translations: [ResponseDeeplData]){
        self.translations = translations
    }
    let translations: [ResponseDeeplData]
}

struct ResponseDeeplData: Codable {
    init(detected_source_language:String, text: String){
        self.detected_source_language = detected_source_language
        self.text = text
    }
    let detected_source_language: String
    let text: String
}

/**
 With or without detection :
 {
     "translations": [
         {
             "detected_source_language": "EN",
             "text": "ok"
         }
     ]
 }
 */
