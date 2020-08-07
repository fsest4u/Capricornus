//
//  Util.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import PopupDialog

class Util {
    
    static var audioPlayer: AVAudioPlayer?

    static func displayPopup(uvc: UIViewController, title: String, message: String) {
        
        let popup = PopupDialog(title: title, message: message)
        let btnOK = DefaultButton(title: "OK", action: nil)
        
        uvc.present(popup, animated: true, completion: nil)
    }
    
    static func getCurrentDate() -> String {
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        var current_date_string = formatter.string(from: Date())
        return current_date_string
    }
    
    static func getDirURL(dirname: String) -> URL {
        
        let fileManager = FileManager.default
        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let dirURL = docURL.appendingPathComponent(arrPlatform[platformType.rawValue])
        let dirURL = docURL.appendingPathComponent(dirname)
        let dirURLPath = dirURL.path
        
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
        
        let dirURL = Util.getDirURL(dirname:dirname)
        //        let filename = Util.getCurrentDate() + ".mp3"
        let filename = dirname + "_" + basename + ".mp3"
        let fileURL = dirURL.appendingPathComponent(filename)
        
        return fileURL
        
    }
    
    static func checkFileURL(url: URL) -> Bool {
        
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: url.path)
        
    }
    
    static func moveMP3List(vc: UIViewController, dirname: String) {
        
        let dirURL = Util.getDirURL(dirname: dirname)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "MP3ListVC") as? MP3ListVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            uvc.dirURL = dirURL
            vc.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
    static func playMP3(uvc: AVAudioPlayerDelegate, fileURL: URL) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = uvc
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        }
        catch {
            print("Error playMP3 file \(fileURL.path)")
        }
    }
    
    static func stopMP3(uvc: AVAudioPlayerDelegate, fileURL: URL) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = uvc
            audioPlayer?.stop()
        }
        catch {
            print("Error stopMP3 fie \(fileURL.path)")
        }
    }
    
    static func deleteMP3(fileURL: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: fileURL)
        }
        catch {
            print("Error deleteMP3 file \(fileURL.path)")
        }
    }
    
    static func debugPlaySample(uvc: AVAudioPlayerDelegate) {
        
        let path = Bundle.main.path(forResource: "sample.mp3", ofType: nil)!
        let fileURL = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = uvc
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        }
        catch {
            print("Error debugPlaySample...")
        }
        
    }
    
    static func checkFileSize(fileURL: URL) {

        let fileManager = FileManager.default
        do {
            let attr = try fileManager.attributesOfItem(atPath: fileURL.path)
            let size = attr[FileAttributeKey.size] as! UInt64
            print("checkFileSize file size : \(size)")
            
        } catch {
            print("Error checkFileSize...")
            
        }
    }
}
