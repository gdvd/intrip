//
//  FakeResponseDataFixer.swift
//  intripTests
//
//  Created by Gilles David on 25/12/2021.
//

import Foundation


class FakeResponseDataFixer {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class DownloadError: Error {}
    static let errorDownload = DownloadError()
    
    
    var downloadCorrectDataFixer: Data {
        let bundle = Bundle(for: FakeResponseDataFixer.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let downloadIncorrectDataFixer = "erreur".data(using: .utf8)!
    
    
}
