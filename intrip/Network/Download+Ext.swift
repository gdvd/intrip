//
//  Download+Ext.swift
//  intrip
//
//  Created by Gilles David on 10/01/2022.
//

import Foundation

extension String {
    var URLEncoded:String {

        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,-.'"
        let unreservedCharsSet: CharacterSet = CharacterSet(charactersIn: unreservedChars)
        let encodedString = self.addingPercentEncoding(withAllowedCharacters: unreservedCharsSet)!
        return encodedString
    }
}
