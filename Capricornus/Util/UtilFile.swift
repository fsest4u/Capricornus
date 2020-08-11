//
//  UtilFile.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/10.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation

class UtilFile {

    static func getDirURL(dirname: String) -> URL {
        
        let fileManager = FileManager.default
        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let dirURL = docURL.appendingPathComponent(arrPlatform[platformType.rawValue])
        let dirURL = docURL.appendingPathComponent(dirname)
        let dirURLPath = dirURL.path
        
//        print("getDirURL: \(dirURLPath)")
        
        if !fileManager.fileExists(atPath: dirURLPath) {
            do {
                try fileManager.createDirectory(atPath: dirURLPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create document directory")
            }
        }
        
        return dirURL
    }
    
    static func getFileURL(dirname: String, basename: String) -> URL {
        
        let dirURL = UtilFile.getDirURL(dirname:dirname)
        //        let filename = Util.getCurrentDate() + ".mp3"
        let filename = dirname + "_" + basename + ".mp3"
        let fileURL = dirURL.appendingPathComponent(filename)
        
        return fileURL
        
    }
    
    static func checkFileURL(url: URL) -> Bool {
        
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: url.path)
        
    }

    static func deleteFile(fileURL: URL) {
        print("deleteFile file \(fileURL.path)")
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: fileURL)
        }
        catch let error as NSError {
            print("Error deleteFile error : \(error)")
        }
    }
    
    static func checkFileSize(fileURL: URL) {

        let fileManager = FileManager.default
        do {
            let attr = try fileManager.attributesOfItem(atPath: fileURL.path)
            let size = attr[FileAttributeKey.size] as! UInt64
            print("checkFileSize file size : \(fileURL.path) \(size)")
            
        } catch {
            print("Error checkFileSize \(fileURL.path)")
            
        }
    }
}
