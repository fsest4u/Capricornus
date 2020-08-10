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
    
    var filename: String?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        stopMP3(dirURL: dirURL!, filename: self.filename ?? "")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func checkFileSize(filename: String) {
        
        let fileURL = (dirURL?.appendingPathComponent(filename))!
        UtilFile.checkFileSize(fileURL: fileURL)
    }
    
    func playMP3(dirURL: URL, filename: String) {
        
        let fileURL = (dirURL.appendingPathComponent(filename))
        UtilAudio.playMP3(uvc: self, fileURL: fileURL)

    }
    
    func stopMP3(dirURL: URL, filename: String) {
        let fileURL = (dirURL.appendingPathComponent(filename))
        UtilAudio.stopMP3(uvc: self, fileURL: fileURL)
    }
    
    func deleteMP3(dirURL: URL, filename: String) {
        
        let fileURL = (dirURL.appendingPathComponent(filename))
        UtilAudio.deleteMP3(fileURL: fileURL)
        
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
        let filename = curCell.labelFileName.text ?? ""
        self.filename = filename
//        debugPlaySample()
//        debugCheckFileSize(filename: filename)
        playMP3(dirURL: dirURL!, filename: filename)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let curCell = tableView.cellForRow(at: indexPath) as! MP3ListCell
            let filename = curCell.labelFileName.text ?? ""
            deleteMP3(dirURL: dirURL!, filename: filename)
            
            arrFile?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}

