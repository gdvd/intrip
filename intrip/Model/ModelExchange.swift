//
//  ModelExchange.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

enum ResponseData {
    case Success
    case OldValues(date: String)
    case Failure(failure: Error)
}

class ModelExchange {
    
    public static let shared = ModelExchange()
    private init() { }
    
    public var currencies = Currencies()
    public var exchangeIn = Constants.exchangeStrDefaultIn
    public var exchangeOut = Constants.exchangeStrDefaultOut
    
    
    public func getLastValues(callback: @escaping(ResponseData) -> Void ) {
        
        if OneFileManager.ifFileExiste(fileName: Constants.fileNameExchangeFixer) { 
            print("File Exist")
            let itemFixerOnDisk = OneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)
            
            if ifTodayIsSameSameOf(dateStr: itemFixerOnDisk.date) {
                // Same Date -> show them
                currencies.initWithDict((OneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)).rates)
                callback( .Success)
            } else {
                // No same Date
                Download.shared.downloadRatesWithFixer { result in
                    switch result {
                    case .Success(response: let response):
                        // Download new values ok
                        self.currencies.initWithDict(response.rates)
                        callback( .Success)
                    case .Failure(failure: _):
                        // Download new values failed -> we will work with old values
                        self.currencies.initWithDict((itemFixerOnDisk).rates)
                        callback( .OldValues(date: itemFixerOnDisk.date))
                    }
                }
            }
        } else { 
            print("No File Exist")
            Download.shared.downloadRatesWithFixer { result in
                switch result {
                case .Success(response: let response):
                    self.currencies.initWithDict(response.rates)
                    OneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: response)
                    callback( .Success)
                case .Failure(failure: let error):
                    callback( .Failure(failure: error))
                }
            }
        }
    }
    
    private func ifTodayIsSameSameOf(dateStr : String) -> Bool {
        let date = Date()
        let dateWithFormat = date.getFormattedDate(format: Constants.formatDateFixer)
        return dateWithFormat == dateStr
    }
}

