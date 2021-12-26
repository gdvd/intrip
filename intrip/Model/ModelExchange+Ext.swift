//
//  ModelExchange+Ext.swift
//  intrip
//
//  Created by Gilles David on 22/12/2021.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
