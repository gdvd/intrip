//
//  ModelExchange.swift
//  intrip
//
//  Created by Gilles David on 20/12/2021.
//

import Foundation

class ModelExchange {
    
    private var items: [ItemFixer]! = []
    
    init() {
        init4Test() ///TEST
    }
    
    /// BEGIN  TEST
    private func init4Test() {
        
        let date = Date()
        let dateWithFormat = date.getFormattedDate(format: "yyyy-MM-dd")
        print(dateWithFormat)
        print("Data file path is \(dataFilePath())")
        print("ifFileExiste : \(ifFileExiste())")
        items = [writeItemFixer4Onetest()]
        saveChecklistItems()
        print("ifFileExiste : \(ifFileExiste())")
    }
    private func writeItemFixer4Onetest() -> ItemFixer {
        let m1 = Money("momaie1",10)
        let m2 = Money("momaie2",20)
        let m = [m1, m2]
        return ItemFixer(success: true, timestamp: 123456, base: "EUR", date: "2021-12-22", rates: m)
    }
    /// END  TEST
    
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory, 
               in: .userDomainMask)
        return paths[0]
    }
    private func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Fixer.plist")
    }
    private func saveChecklistItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(
                to: dataFilePath(), 
                options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    private func loadChecklistItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
          let decoder = PropertyListDecoder()
          do {
            items = try decoder.decode(
              [ItemFixer].self, 
              from: data)
          } catch {
            print("Error decoding item array: \(error.localizedDescription)")
          }
        }
      }
    func ifFileExiste() -> Bool{
        guard FileManager().fileExists(atPath: dataFilePath().path) else {
            return false
        }
        return true
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
