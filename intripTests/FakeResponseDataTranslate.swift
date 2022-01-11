//
//  FakeResponseDataTranslate.swift
//  intripTests
//
//  Created by Gilles David on 11/01/2022.
//

import Foundation

class FakeResponseDataTranslate {
    
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                            statusCode: 200, 
                                            httpVersion: nil, 
                                            headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                     statusCode: 500, 
                                     httpVersion: nil, 
                                     headerFields: nil)!
    
    
    class DownloadError: Error {}
    let errorDownload = DownloadError()
    
    
    static var downloadCorrectDataWeather: Data {
        let bundle = Bundle(for: FakeResponseDataTranslate.self)
        let url = bundle.url(forResource: "ResponseDeepl", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let downloadIncorrectDataFixer = "erreur".data(using: .utf8)!
}
