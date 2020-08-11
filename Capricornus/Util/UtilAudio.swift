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
    static var audioRecorder: AVAudioRecorder?
    static var audioSession: AVAudioSession?

    static func playMP3(uvc: AVAudioPlayerDelegate, fileURL: URL) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = uvc
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("start play")

        }
        catch let error as NSError {
            print("Error playMP3 file \(fileURL.path), error : \(error)")
        }
    }
    
    static func stopToPlay() {
        
        do {
            if audioRecorder != nil {
                print("stop to record")
                audioRecorder?.stop()
                audioRecorder = nil
            }
            else {
                print("stop to play")
                audioPlayer?.stop()
            }
        }
        catch let error as NSError {
            print("Error stopToPlay file ")
        }
    }

    static func recordMP3(uvc: AVAudioRecorderDelegate, fileURL: URL) {

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() {_ in
                print("ready to record")
            }
            if audioRecorder == nil {
                audioRecorder = try AVAudioRecorder(url: fileURL, settings: RECORD_SETTING)
                audioRecorder?.delegate = uvc
    //            audioRecorder?.prepareToRecord()
                audioRecorder?.record()
                print("start record")
            }
            
        }
        catch let error as NSError {
            print("Error recordMP3 file \(fileURL.path), error : \(error)")
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
        catch let error as NSError {
            print("Error debugPlaySample...")
        }
        
    }

}
