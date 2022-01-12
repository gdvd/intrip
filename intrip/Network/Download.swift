//
//  Download.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

enum Networkresponse<T: Codable> {
    case Success(response: T)
    case Failure(failure: ErrorFailure)
}

enum ErrorFailure: Error {
    case returnNil
    case statusCodeWrong
    case decodeError
}


class Download {
    
    public static let shared = Download()
    private var task: URLSessionDataTask?
    
    private init(){ }
    
    // 4 XCTest
    private var session = URLSession(configuration: .default)
    init(session: URLSession){
        self.session = session
    }
  
    public func downloadTranslate(textToTranslate: String, langIn: String, langOut: String, autoDetect: Bool, completionHandler: @escaping (Networkresponse<ResponseDeeplData>) -> Void) {
        
        var urlStr = Constants.urlApiDeepl
            .replacingOccurrences(of: Constants.APIkeyPattern, with: ApiKeys.keyDeepl)
            .replacingOccurrences(of: Constants.textToTranslatePattern, with: textToTranslate.URLEncoded)
        
        urlStr = urlStr + langOut
        
        if !autoDetect {
            urlStr = urlStr + Constants.optionSourceLang + langIn
        }
                
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.Failure(failure: ErrorFailure.statusCodeWrong))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(ResponseDeepl.self, from: data) else{
                completionHandler(.Failure(failure: ErrorFailure.decodeError))
                return
            }
            completionHandler(.Success(response: responseJSON.translations[0]))
        } 
        task?.resume()
    }
    
    public func downloadWeatherData(lon: String, lat: String, completionHandler: @escaping (Networkresponse<OpenWeatherMap>) -> Void) {
        let url = URL(string: Constants.urlApiOpenweathermap
                        .replacingOccurrences(of: Constants.APIkeyPattern, with: ApiKeys.keyOpenWeather)
                        .replacingOccurrences(of: Constants.latOpenweathermapPattern, with: lat)
                        .replacingOccurrences(of: Constants.lonOpenweathermapPattern, with: lon))
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.Failure(failure: ErrorFailure.statusCodeWrong))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(OpenWeatherMap.self, from: data) else{
                completionHandler(.Failure(failure: ErrorFailure.decodeError))
                return
            }
            completionHandler(.Success(response: responseJSON))
        } 
        task?.resume()
    }
    
    public func downloadRatesWithFixer(completionHandler: @escaping (Networkresponse<ItemFixer>) -> Void) {
        let url = URL(string: (Constants.urlApiFixer.replacingOccurrences(of: Constants.APIkeyPattern, with: ApiKeys.keyFixer)))!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //print("Download Fixer now : " + request.description)
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(Networkresponse.Failure(failure: ErrorFailure.returnNil))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.Failure(failure: ErrorFailure.statusCodeWrong))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(ItemFixer.self, from: data) else{
                completionHandler(.Failure(failure: ErrorFailure.decodeError))
                return
            }
            completionHandler(.Success(response: responseJSON))
        }
        task?.resume()
    }
}
