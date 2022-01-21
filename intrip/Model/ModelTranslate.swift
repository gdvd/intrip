//
//  ModelTranslate.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation



class ModelTranslate {
    
    public var languages: [Language] = []
    
    public static let shared = ModelTranslate()
    private init() {
        getLanguages()
    }
    
    // 4 XCTest
    private var download = Download.shared
    init(download: Download){
        self.download = download
        getLanguages()
    }
    
    public func getTranslateSentence(textToTranslate: String, langIn: String, langOut: String, autoDetect: Bool, completion: @escaping (Networkresponse<ResponseDeeplData>) -> Void) {

        download.downloadTranslate(textToTranslate: textToTranslate.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!, langIn: langIn, langOut: langOut, autoDetect: autoDetect) { response in
            switch response {
            case .Success(response: let data):
                completion(.Success(response: data))
            case .Failure(let error):
                switch error {
                case .returnNil:
                    completion(.Failure(failure: ErrorFailure.returnNil))
                case .statusCodeWrong:
                    completion(.Failure(failure: ErrorFailure.statusCodeWrong))
                case .decodeError:
                    completion(.Failure(failure: ErrorFailure.decodeError))
                }
            }
        }
        
    }
    
    private func getLanguages(){
        let bundle = Bundle(for: ModelTranslate.self)
        let url = bundle.url(forResource: "SourceLang", withExtension: "json")
        
        if let data = try? Data(contentsOf: url!) {
            guard let responseJSON = try? JSONDecoder().decode(Languages.self, from: data) else{
                return
            }
            languages = responseJSON.languages
        }
    }
    public func getPosInLanguage(lan: String) -> Int {
        if let pos = languages.enumerated().first(where: {$0.element.code.lowercased() == lan.lowercased()}) {
            return pos.offset
        } else {
           return -1
        }
    }
    public func getLangInLanguage(pos: Int) -> String {
        if pos <= languages.count {
            return languages[pos].lang
        } else {
            return ""
        }
    }
    public func getCodeInLanguage(pos: Int) -> String {
        if pos <= languages.count {
            return languages[pos].code
        } else {
            return ""
        }
    }
    
}
