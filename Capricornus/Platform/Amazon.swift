//
//  Amazon.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/12.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AWSPolly

class Amazon {
    
    var uvc: UIViewController?
    
    var audioPlayer = AVPlayer()
    
    func doAmazon(arrContent: [String], index: Int) {
        
        let voice = AWSPollyVoiceId.seoyeon
        
        let input = AWSPollySynthesizeSpeechURLBuilderRequest()
        input.text = arrContent[index]
        input.outputFormat = AWSPollyOutputFormat.mp3
        input.voiceId = voice
        
        
        let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)
        // Request the URL for synthesis result
        builder.continueOnSuccessWith { (awsTask: AWSTask<NSURL>) -> Any? in
            // The result of getPresignedURL task is NSURL.
            // Again, we ignore the errors in the example.
            let url = awsTask.result!
            print("doAmazon : \(url.path)")
            
            // Try playing the data using the system AVAudioPlayer
            self.audioPlayer.replaceCurrentItem(with: AVPlayerItem(url: url as URL))
            self.audioPlayer.play()

            return nil
        }
        
    }
    
//    func downloadAmazon() {
//
//    }
}
