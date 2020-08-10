//
//  UtilAudio.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/10.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class UtilAudio {

    static var audioPlayer: AVAudioPlayer?

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

}
