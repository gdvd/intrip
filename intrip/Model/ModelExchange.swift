//
//  ModelExchange.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//
import os.log
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
    private init() { 
        self.currencies = Currencies()
    }
    public var currencies: Currencies
    public var oneFileManager = OneFileManager()
    
    // 4 XCTest
    init(currencyFake: Currencies) {
        self.currencies = currencyFake
    }
    private var download = Download.shared
    init(currencyFake: Currencies, download: Download, oneFileManager: OneFileManager){
        self.download = download
        self.currencies = currencyFake
        self.oneFileManager = oneFileManager
    }
    
    
    public func getLastValues(callback: @escaping(ResponseData) -> Void ) {
        
        if oneFileManager.ifFileExist(fileName: Constants.fileNameExchangeFixer) { 
            let itemFixerOnDisk = oneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)!
            if oneFileManager.ifTodayIsSameOf(dateStr: itemFixerOnDisk.date) {
                // File Exist! - Same Date -> show them
                currencies.initWithDictAndSort((oneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)!).rates)
                callback( .Success)
            } else {
                // File Exist - No same Date -> Reload
                download.downloadRatesWithFixer { result in
                    switch result {
                    case .Success(response: let response):
                        // Download new values ok
                        self.currencies.initWithDictAndSort(response.rates)
                        self.oneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: response)
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
            download.downloadRatesWithFixer { result in
                switch result {
                case .Success(response: let response):
                    self.currencies.initWithDictAndSort(response.rates)
                    self.oneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: response)
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
    
    private func verifyIfDataExist() -> Bool {
        return currencies.names.count > 0
    }
}

