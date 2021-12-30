//
//  Download.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

enum Networkresponse<T: Codable> {
    case Success(response: T)
    case Failure(failure: Error)
}

enum Failure: Error {
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
    
    public func downloadRatesWithFixer(completionHandler: @escaping (Networkresponse<ItemFixer>) -> Void) {
        let url = URL(string: (Constants.urlApiFixer.replacingOccurrences(of: Constants.APIkeyExchangeFixerPattern, with: ApiKeys.keyFixer)))!
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("Download now : " + request.description)
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(.Failure(failure: Failure.returnNil))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(.Failure(failure: Failure.statusCodeWrong))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ItemFixer.self, from: data) else{
                    completionHandler(.Failure(failure: Failure.decodeError))
                    return
                }
                completionHandler(.Success(response: responseJSON))
            }
        } 
        task?.resume()
    }
}
