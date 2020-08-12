//
//  RecordListVC.swift
//  Capricornus
//
//  Created by 이동윤 on 2020/08/07.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import AVFoundation

class RecordListVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var viewRecord: UIView! {
           
        didSet {
            viewRecord.layer.borderWidth = 0.5
            viewRecord.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
            viewRecord.layer.cornerRadius = (viewRecord.frame.width / 2)
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var dirURL: URL?
    
    var arrFile: [String]?
    
    var filename: String?
    
    var naver = Naver()
    var kakao = Kakao()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getFileList()
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
            let filename = Util.getCurrentDate() + ".m4a"
            recordMP3(dirURL: dirURL!, filename: filename)
            
        }
        else {
            stopToPlay()
        }
    }
    
    func getFileList() {
        
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
    
    func checkFileSize(dirURL: URL, filename: String) {
        
        let fileURL = dirURL.appendingPathComponent(filename)
        UtilFile.checkFileSize(fileURL: fileURL)
    }
    
    func recordMP3(dirURL: URL, filename: String) {
        
        deleteMP3(dirURL: dirURL, filename: filename)
        
        let fileURL = dirURL.appendingPathComponent(filename)
        UtilAudio.recordMP3(uvc: self, fileURL: fileURL)
    }

    func playMP3(dirURL: URL, filename: String) {
        
//        deleteMP3(dirURL: dirURL, filename: filename)
        
        let fileURL = dirURL.appendingPathComponent(filename)
        UtilAudio.playMP3(uvc: self, fileURL: fileURL)
    }
    
    func stopToPlay() {

        UtilAudio.stopToPlay()
        getFileList()
        tableView.reloadData()
    }
    
    func deleteMP3(dirURL: URL, filename: String) {
        
        let fileURL = (dirURL.appendingPathComponent(filename))
        UtilFile.deleteFile(fileURL: fileURL)
        
    }
    
    
    
}

extension RecordListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFile?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListCell
        
        cell.labelFileName.text = arrFile?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let curCell = tableView.cellForRow(at: indexPath) as! PlayListCell
        let filename = curCell.labelFileName.text ?? ""
        self.filename = filename
        let fileURL = (dirURL?.appendingPathComponent(filename))!
        
        switch sttPlatformType {
        case STTPlatformType.NAVER_CSR:
            naver.uvc = self
            naver.doNaverCSR(fileURL: fileURL)
        case STTPlatformType.KAKAO:
            print("Kakao")
            kakao.uvc = self
            kakao.doKakaoRec(fileURL: fileURL)
        case STTPlatformType.AWS:
            print("준비 중...")
            
        case STTPlatformType.GOOGLE:
            print("준비 중...")
        }

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let curCell = tableView.cellForRow(at: indexPath) as! PlayListCell
            let filename = curCell.labelFileName.text ?? ""
            deleteMP3(dirURL: dirURL!, filename: filename)
            
            arrFile?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
