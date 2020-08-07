//
//  Naver.swift
//  Capricornus
//
//  Created by 이동윤 on 2020/08/07.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import RxSwift
import SwiftyJSON
import PopupDialog

class Naver {

    var uvc: UIViewController?
    var fileURL: URL?
    
    var disposeBag = DisposeBag()

    func doNaverCSS(arrSpeaker: [String], arrContent: [String], index: Int) {
        
        fileURL = Util.getFileURL(dirname: arrPlatform[platformType.rawValue], basename: arrSpeaker[index])
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL?.path ?? "") {
            if DEBUG_MODE {
                Util.moveMP3List(vc: uvc ?? UIViewController(), dirname: arrPlatform[platformType.rawValue])
            }
            else {
                Util.playMP3(uvc: uvc as! AVAudioPlayerDelegate, fileURL: fileURL!)
            }
        }
        else {
            let speaker = arrSpeaker[index]
            let content = arrContent[index]
            downloadNaverCSS(content: content, speaker: speaker)
        }
        
    }
    
    func doNaverCPV(arrSpeaker: [String], arrContent: [String], index: Int) {
        
        fileURL = Util.getFileURL(dirname: arrPlatform[platformType.rawValue], basename: arrSpeaker[index])
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL?.path ?? "") {
            if DEBUG_MODE {
                Util.moveMP3List(vc: uvc ?? UIViewController(), dirname: arrPlatform[platformType.rawValue])
            }
            else {
                Util.playMP3(uvc: uvc as! AVAudioPlayerDelegate, fileURL: fileURL!)
            }
        }
        else {
            let speaker = arrSpeaker[index]
            let content = arrContent[index]
            downloadNaverCPV(content: content, speaker: speaker)
        }
    }
    
    func downloadNaverCSS(content: String, speaker: String, speed: Int = 0) {
        
        print("downloadNaverCSS content: \(content)")
        let header = APIParameter.getNaverHeaderItem()
        let param = APIParameter.postNaverCSS(content: content, speaker: speaker, speed: speed)
        
        guard let urlComps = NSURLComponents(string: API_PATH_NAVER_HOST + API_PATH_NAVER_CSS) else{
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
                if dataJson["error"].isEmpty {
                    // 입력데이타를 파일로 저장
                    do {
                        try data.write(to: (self?.fileURL)!)
                        
                    } catch {
                        print("Something went wrong!")
                    }
                    
                    if DEBUG_MODE {
                        // move to vc of mp3 list
                        Util.moveMP3List(vc: self?.uvc ?? UIViewController(), dirname: arrPlatform[platformType.rawValue])
                    }
                    else {
                        // play mp3
                        Util.playMP3(uvc: self?.uvc as! AVAudioPlayerDelegate, fileURL: (self?.fileURL)!)
                    }
                    
                }
                else {
                    // popup
                    let error = dataJson["error"]
                    let message = error["message"].string ?? "에러발생"
                    Util.displayPopup(uvc: self?.uvc ?? UIViewController(), title: "Error", message: message)
                }
                
                },onError: {
                    error in
                    
                    
            },onCompleted: {
                //                LoadingHUD.hide()
                
                
            }).disposed(by: disposeBag)
    }
    
    func downloadNaverCPV(content: String, speaker: String, speed: Int = 0, volume: Int = 0, pitch: Int = 0, emotion: Int = 0, format: String = "mp3") {
        
        print("downloadNaverCSS content: \(content)")
        let header = APIParameter.getNaverHeaderItem()
        let param = APIParameter.postNaverCPV(content: content, speaker: speaker, speed: speed, volume: volume, pitch: pitch, emotion: emotion, format: format)
        
        guard let urlComps = NSURLComponents(string: API_PATH_NAVER_HOST + API_PATH_NAVER_CPV) else{
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
                if dataJson["error"].isEmpty {
                    // 입력데이타를 파일로 저장
                    do {
                        try data.write(to: (self?.fileURL)!)
                        
                    } catch {
                        print("Something went wrong!")
                    }
                    
                    if DEBUG_MODE {
                        // move to vc of mp3 list
                        Util.moveMP3List(vc: self?.uvc ?? UIViewController(), dirname: arrPlatform[platformType.rawValue])
                    }
                    else {
                        // play mp3
                        Util.playMP3(uvc: self?.uvc as! AVAudioPlayerDelegate, fileURL: (self?.fileURL)!)
                    }
                    
                }
                else {
                    // popup
                    let error = dataJson["error"]
                    let message = error["message"].string ?? "에러발생"
                    Util.displayPopup(uvc: self?.uvc ?? UIViewController(), title: "Error", message: message)
                }
                
                },onError: {
                    error in
                    
                    
            },onCompleted: {
                //                LoadingHUD.hide()
                
                
            }).disposed(by: disposeBag)
    }
    
}
