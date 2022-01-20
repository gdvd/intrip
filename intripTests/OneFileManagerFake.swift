//
//  OneFileManagerFake.swift
//  intripTests
//
//  Created by Gilles David on 20/01/2022.
//

import Foundation
@testable import intrip


class OneFileManagerFake: OneFileManager {
    
    enum FileExist {
        case Yes
        case No
    }
    enum Today {
        case Yes
        case No
    }
    var fileExist: FileExist = .No
    var today: Today = .No
    init(fileExist: FileExist, today: Today) {
        self.fileExist = fileExist
        self.today = today
    }
    
    override func ifFileExist(fileName: String) -> Bool {
        switch fileExist {
        case .Yes:
            return true
        case .No:
            return false
        }
    }
    override func loadItemsFixer(fileName: String) -> ItemFixer {
        let rates = ["": 1.0]
        return ItemFixer(success: true, timestamp: 1, base: "", date: "2022-01-20", rates: rates)
        
    }
    override func ifTodayIsSameSameOf(dateStr: String) -> Bool {
        switch today {
        case .Yes:
            return true
        case .No:
            return false
        }
    }
}
