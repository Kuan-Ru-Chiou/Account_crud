//
//  Record.swift
//  記帳
//
//  Created by 邱冠儒 on 2019/7/26.

//

import Foundation



struct Record: Codable {
    
    var title: String
    var cost: String
    var type: Int
    
    // document path
     static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    // key 避免打字錯誤編譯器沒看出來
    static let key = "records"
    
    //屬性方法給所有檔案都能用 save file ㄒ只需要初始化一次
    static func saveToFile(records: [Record]) {
        
        //產生解碼器 寫入檔案用
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(records) {
            
            // Document Directory
            let url = Record.documentDirectory.appendingPathComponent(key)
            try? data.write(to: url)
            
        
        }
    }
    
     //屬性方法給所有檔案都能用 read file
        static func readFromFile() -> [Record]? {
        let propertyDecoder = PropertyListDecoder()
        
        // Method1: Document Directory
        let url = Record.documentDirectory.appendingPathComponent(key)
        if let data = try? Data(contentsOf: url), let records = try? propertyDecoder.decode([Record].self, from: data) {
            return records
        } else {
            return nil
        }
        

    }
    
    //屬性方法給所有檔案都能用 delete file 整個都砍掉
    static func deleteFile() {
        do {
            let url = Record.documentDirectory.appendingPathComponent(key)
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    

    
}
