//
//  SpeechVC.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import SwiftyJSON

class SpeechVC: UIViewController, AVAudioPlayerDelegate {
    
    var index = 0
    
    var fileURL: URL?
    
    var audioPlayer: AVAudioPlayer?

    
    var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("SpeechVC index : \(index)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
    func getDirURL() -> URL {
        
        let fileManager = FileManager.default
        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dirURL = docURL.appendingPathComponent(arrPlatform[platformType.rawValue])
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
    
    func getFileURL() -> URL {

        let dirURL = getDirURL()
//        let filename = Util.getCurrentDate() + ".mp3"
        let filename = arrPlatform[platformType.rawValue] + "_" + arrSpeaker[index] + ".mp3"
        let fileURL = dirURL.appendingPathComponent(filename)
        
        return fileURL

    }
    
    func checkFileURL(url: URL) -> Bool {
        
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: url.path)
        
    }
    
    func moveMP3List() {

        let dirURL = getDirURL()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "MP3ListVC") as? MP3ListVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            uvc.dirURL = dirURL
            self.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
    func playMP3(fileURL: URL) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        }
        catch {
            print("Error prepare to play...")
        }
    }
    
    func doNaverCSS() {
        
        fileURL = getFileURL()
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL?.path ?? "") {
            playMP3(fileURL: fileURL!)
        }
        else {
            let speed = "0"
            let speaker = arrSpeaker[index]
            let content = arrContent[index]
            downloadNaverCSS(speaker: speaker, speed: speed, content: content)
//            moveMP3List()
        }

    }

    func downloadNaverCSS(speaker: String, speed: String, content: String) {
       
        print("downloadNaverCSS content: \(content)")
        let header = APIParameter.getHeaderItem()
        let param = APIParameter.postNaverCSS(speaker: speaker, speed: speed, content: content)
        
        guard let urlComps = NSURLComponents(string: API_PATH_NAVER_CSS) else{
            return
        }
        
        guard let url = urlComps.url else{
            return
        }
        
//        LoadingHUD.show()
        APIService.request(url: url, method: .post, param: param, header: header)
//            .filter{AppServiceErrorCode.checkData(vc: self, data: $0)}
            .subscribe(onNext: {
                [weak self] data in

                print("data : \(String(decoding: data, as: UTF8.self))")

                let dataJson = JSON(data)
                if dataJson["errorCode"].isEmpty {
                    // 입력데이타를 파일로 저장
                    do {
                        try data.write(to: (self?.fileURL)!)

                    } catch {
                        print("Something went wrong!")
                    }
                 
                    if DEBUG_MODE {
                        // move to vc of mp3 list
                        self?.moveMP3List()
                    }
                    else {
                        // play mp3
                        self?.playMP3(fileURL: (self?.fileURL)!)
                    }
                    
                }
                else {
                    // popup
                }
                
                },onError: {
                    error in

                    
            },onCompleted: {
                //                LoadingHUD.hide()


            }).disposed(by: disposebag)
    }
    


}

extension SpeechVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SpeechCell = tableView.dequeueReusableCell(withIdentifier: "SpeechCell", for: indexPath) as! SpeechCell
        
        cell.labelTitle.text = arrTitle[indexPath.row]
        cell.labelContent.text = arrContent[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        switch platformType {
            case PlatformType.NAVER_CSS:
                
                doNaverCSS()
            
            case PlatformType.NAVER_CPV:
                print("type NAVER_CPV")

            case PlatformType.KAKAO:
                print("type KAKAO")
            
            case PlatformType.AWS:
                print("type AWS")
            
            case PlatformType.GOOGLE:
                print("type GOOGLE")
            
            case PlatformType.MICROSOFT:
                print("type MICROSOFT")
            
            case PlatformType.IBM:
                print("type IBM")
            
            default:
                print("type NONE")

        }
    }
    
    
}

class SpeechCell: UITableViewCell {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
}
