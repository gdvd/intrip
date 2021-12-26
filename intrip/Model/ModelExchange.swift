//
//  ModelExchange.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

class ModelExchange {
    
    public static let shared = ModelExchange()
    
    private var items: ItemFixer!
    
    private init() { }
    
    
    public func getLastValues(){
        if OneFileManager.ifFileExiste(fileName: Constants.fileNameExchangeFixer) {
            // File exist
            print("exist")
            items = OneFileManager.loadItemsFixer(fileName: Constants.fileNameExchangeFixer)
            
            // Test if Date is same
            let date = Date()
            let dateWithFormat = date.getFormattedDate(format: Constants.formatDateFixer)
            print(dateWithFormat,dateWithFormat.count, dateWithFormat == items.date)
            if dateWithFormat == items.date {
                // Date identique
                // Show values
            } else {
                // Date differente
                Download.shared.downloadRatesWithFixer { item in
                    if let items = item {
                        OneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: items)
                        // Show new values
                    } else {
                        print("ItemFixer == nil -> Old values is here")
                    }
                }
            }
        } else {
            // No file exist
            print("No exist")
            Download.shared.downloadRatesWithFixer { item in
                if let items = item {
                    OneFileManager.saveChecklistItemsFixer(fileName: Constants.fileNameExchangeFixer, itemToSave: items)
                } else {
                    print("ItemFixer == nil -> No value available")
                }
            }
        }
    }
     
}

