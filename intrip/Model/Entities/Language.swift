//
//  Lang.swift
//  intrip
//
//  Created by Gilles David on 09/01/2022.
//

import Foundation

struct Language: Codable {
    
    init(code: String, lang: String){
        self.code = code
        self.lang = lang
    }
    
    var code: String
    var lang: String
    
}

struct Languages: Codable {
    init(languages:[Language]){
        self.languages = languages
    }
    var languages:[Language]
}
