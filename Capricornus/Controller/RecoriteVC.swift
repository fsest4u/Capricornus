//
//  STTVC.swift
//  Capricornus
//
//  Created by 이동윤 on 2020/08/07.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import AVFoundation

class RecoriteVC: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var viewRecord: UIView! {
           
        didSet {
            viewRecord.layer.borderWidth = 0.5
            viewRecord.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
            viewRecord.layer.cornerRadius = (viewRecord.frame.width / 2)
        }
        
    }
    
    var dirURL: URL?
    
    var filename: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        stopToPlay()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClick_BtnRecord(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            recordMP3(dirURL: dirURL!, filename: "test.m4a")
            
        }
        else {
            stopToPlay()
        }
    }
    
    func recordMP3(dirURL: URL, filename: String) {
        
        deleteMP3(dirURL: dirURL, filename: filename)
        
        print("start record...")
        let fileURL = dirURL.appendingPathComponent(filename)
        UtilAudio.recordMP3(uvc: self, fileURL: fileURL)
    }
    
    func stopToPlay() {
        print("stop record...")
        UtilAudio.stopToRecord()
    }
    
    func deleteMP3(dirURL: URL, filename: String) {
        
        let fileURL = (dirURL.appendingPathComponent(filename))
        UtilFile.deleteFile(fileURL: fileURL)
        
    }
    
}
