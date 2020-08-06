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
    
    var indexRow = 0
    
    var fileURL: URL?
    
    var audioPlayer: AVAudioPlayer?

    var arrTitle: [String] = []
    var arrSpeaker: [String] = []
    var arrContent: [String] = []
    
    var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("SpeechVC platformType : \(platformType)")
        initArrayData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func initArrayData() {
        
        switch platformType {
            case PlatformType.NAVER_CSS:
                arrTitle = arrNaverCSSTitle
                arrSpeaker = arrNaverCSSSpeaker
                arrContent = arrNaverCSSContent
            case PlatformType.NAVER_CPV:
                arrTitle = arrNaverCPVTitle
                arrSpeaker = arrNaverCPVSpeaker
                arrContent = arrNaverCPVContent
            default:
                break
        }
    }

    
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
        let filename = arrPlatform[platformType.rawValue] + "_" + arrSpeaker[indexRow] + ".mp3"
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
            let speaker = arrSpeaker[indexRow]
            let content = arrContent[indexRow]
            downloadNaverCSS(content: content, speaker: speaker)
        }

    }
    
    func doNaverCPV() {
        
        fileURL = getFileURL()
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL?.path ?? "") {
            playMP3(fileURL: fileURL!)
        }
        else {
            let speaker = arrSpeaker[indexRow]
            let content = arrContent[indexRow]
            downloadNaverCPV(content: content, speaker: speaker)
        }
    }

    func downloadNaverCSS(content: String, speaker: String, speed: Int = 0) {
       
        print("downloadNaverCSS content: \(content)")
        let header = APIParameter.getHeaderItem()
        let param = APIParameter.postNaverCSS(content: content, speaker: speaker, speed: speed)
        
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
    
    func downloadNaverCPV(content: String, speaker: String, speed: Int = 0, volume: Int = 0, pitch: Int = 0, emotion: Int = 0, format: String = "mp3") {
           
            print("downloadNaverCSS content: \(content)")
            let header = APIParameter.getHeaderItem()
            let param = APIParameter.postNaverCPV(content: content, speaker: speaker, speed: speed, volume: volume, pitch: pitch, emotion: emotion, format: format)
            
            guard let urlComps = NSURLComponents(string: API_PATH_NAVER_CPV) else{
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
        
        indexRow = indexPath.row
        
        switch platformType {
            case PlatformType.NAVER_CSS:
                
                doNaverCSS()
            
            case PlatformType.NAVER_CPV:
            
                doNaverCPV()

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
