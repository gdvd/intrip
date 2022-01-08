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
enum returnValues {
    case newalues(valueMoneyIn: String, valueMoneyOut: String)
}

class ModelExchange {
    
    public static let shared = ModelExchange()
    private init() { }
    
    public var currencies = Currencies()
    public var exchangeIn = Constants.exchangeStrDefaultIn
    public var exchangeOut = Constants.exchangeStrDefaultOut
    
    
    public func getLastValues(callback: @escaping(ResponseData) -> Void ) {
        
        if OneFileManager.ifFileExist(fileName: Constants.fileNameExchangeFixer) { 
            let itemFixerOnDisk = OneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)
            
            if ifTodayIsSameSameOf(dateStr: itemFixerOnDisk.date) {
                // File Exist - Same Date -> show them
                currencies.initWithDictAndSort((OneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)).rates)
                callback( .Success)
            } else {
                // File Exist - No same Date -> Reload
                Download.shared.downloadRatesWithFixer { result in
                    switch result {
                    case .Success(response: let response):
                        // Download new values ok
                        self.currencies.initWithDictAndSort(response.rates)
                        OneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: response)
                        callback( .Success)
                    case .Failure(failure: _):
                        // Download new values failed -> we will work with old values
                        self.currencies.initWithDictAndSort(itemFixerOnDisk.rates)
                        callback( .OldValues(date: itemFixerOnDisk.date))
                    }
                }
            }
        } else { 
            // No File Exist
            Download.shared.downloadRatesWithFixer { result in
                switch result {
                case .Success(response: let response):
                    self.currencies.initWithDictAndSort(response.rates)
                    OneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: response)
                    callback( .Success)
                case .Failure(failure: let error):
                    callback( .Failure(failure: error))
                }
            }
        }
    }
    
    public func moneyInChange(valTxtIn: String, currencyIn: Int, currencyOut: Int) -> (valueMoneyIn : String , valueMoneyOut :String){
        if !verifyIfDataExist(){
            return (valueMoneyIn : "0", valueMoneyOut : "0")
        }
        let doubleMoneyIn = checkFormat(valTxtIn)

        if doubleMoneyIn == 0 && !valTxtIn.starts(with: "0.") {
            return (valueMoneyIn : "0", valueMoneyOut : "0")
        } else {
            let moneyOut = (doubleMoneyIn * currencies.getRatio(currencyIn,currencyOut )).description
            return (valueMoneyIn : valTxtIn, valueMoneyOut : moneyOut)
        }
    }
    
    public func moneyOutChange(valTxtOut: String, currencyOut: Int, currencyIn: Int) -> (valueMoneyIn : String , valueMoneyOut :String){
        
        if !verifyIfDataExist(){
            return (valueMoneyIn : "0", valueMoneyOut : "0")
        }
        let doubleMoneyOut = checkFormat(valTxtOut)
        
        if doubleMoneyOut == 0 && !valTxtOut.contains(".") {
            return (valueMoneyIn : "0", valueMoneyOut : "0")
        } else {
            let moneyIn = (doubleMoneyOut / currencies.getRatio(currencyIn,currencyOut )).description
            return (valueMoneyIn : moneyIn, valueMoneyOut : valTxtOut)
        }
    }
    private func checkFormat(_ txt: String) -> Double{
        let myDouble = Double(txt) ?? 0.0
        return myDouble
    }
    
    private func ifTodayIsSameSameOf(dateStr : String) -> Bool {
        let date = Date()
        let dateWithFormat = date.getFormattedDate(format: Constants.formatDateFixer)
        return dateWithFormat == dateStr
    }
    private func verifyIfDataExist() -> Bool {
        return currencies.names.count > 0
    }
}

