//
//  OneFileManager.swift
//  intrip
//
//  Created by Gilles David on 23/12/2021.
//

import Foundation

class OneFileManager {
    
    public func ifFileExist(fileName: String) -> Bool{
        return FileManager().fileExists(atPath: documentsDirectory().path + "/" + fileName)
    }
      
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory, 
               in: .userDomainMask)
        return paths[0]
    }
    
    public func saveChecklistItemsFixer(fileName: String, itemToSave:ItemFixer) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemToSave)
            try data.write(
                to: documentsDirectory().appendingPathComponent(fileName), 
                options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    public func loadItemsFixer(fileName: String) -> ItemFixer {
        var itemToSave:ItemFixer!
        let path = documentsDirectory().appendingPathComponent(fileName) 
        if let data = try? Data(contentsOf: path) {
          let decoder = PropertyListDecoder()
          do {
              itemToSave = try decoder.decode(ItemFixer.self, 
              from: data)
          } catch {
            print("Error decoding item array: \(error.localizedDescription)")
          }
        }
        return itemToSave
      }
    public func ifTodayIsSameSameOf(dateStr : String) -> Bool {
        let date = Date()
        let dateWithFormat = date.getFormattedDate(format: Constants.formatDateFixer)
        return dateWithFormat == dateStr
    }
}
