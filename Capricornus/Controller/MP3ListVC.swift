//
//  MP3ListVC.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import AVFoundation

class MP3ListVC: UIViewController, AVAudioPlayerDelegate {
    
    var dirURL: URL?
    
    var arrFile: [String]?
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            guard let url = dirURL else {
                return
            }
            let path = url.path
            let fileManager = FileManager.default
            arrFile = try fileManager.contentsOfDirectory(atPath: path)
        } catch let error as NSError {
            print("Error access directory : \(error)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func debugPlaySample() {
        
        let path = Bundle.main.path(forResource: "sample.mp3", ofType: nil)!
        let fileURL = URL(fileURLWithPath: path)
        
        do {
            print("debugPlaySample: \(fileURL.path)")
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        }
        catch {
            print("Error prepare to play...")
        }
        
    }
    
    func debugCheckFileSize(filename: String) {

        let fileURL = (dirURL?.appendingPathComponent(filename))!
        let fileManager = FileManager.default
        do {
            let attr = try fileManager.attributesOfItem(atPath: fileURL.path)
            let size = attr[FileAttributeKey.size] as! UInt64
            print("debugCheckFileSize file size : \(size)")
            
        } catch {
            print("Error attributesOfItem...")
            
        }
    }
    
    func playMP3(filename: String) {
        
        let fileURL = (dirURL?.appendingPathComponent(filename))!

        do {
            print("playMP3: \(fileURL.path)")
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        }
        catch {
            print("Error prepare to play...")
        }
    }

}

extension MP3ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFile?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MP3ListCell", for: indexPath) as! MP3ListCell
        
        cell.labelFileName.text = arrFile?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let curCell = tableView.cellForRow(at: indexPath) as! MP3ListCell
        let filename = curCell.labelFileName.text
        
//        debugPlaySample()
//        debugCheckFileSize(filename: filename)
        playMP3(filename: filename!)
        
    }
    
    
}

class MP3ListCell: UITableViewCell {
    
    @IBOutlet weak var labelFileName: UILabel!
    
}
