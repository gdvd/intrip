//
//  Download.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

class Download {
    
    public static let shared = Download()
    private var task: URLSessionDataTask?
    
    private init(){ }
    
    // 4 XCTest
    private var session = URLSession(configuration: .default)
    init(session: URLSession){
        self.session = session
    }
    
    public func downloadRatesWithFixer(completionHandler: @escaping (ItemFixer?) -> Void) {
        let url = URL(string: (Constants.urlApiFixer.replacingOccurrences(of: "{APIkey}", with: ApiKeys.keyFixer)))!
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(ItemFixer.self, from: data) else{
                    completionHandler(nil)
                    return
                }
                completionHandler(responseJSON)
            }
        } 
        task?.resume()
    }
}
