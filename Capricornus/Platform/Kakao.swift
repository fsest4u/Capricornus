//
//  Kakao.swift
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


class Kakao {
    
    var uvc: UIViewController?
    var fileURL: URL?

    var disposeBag = DisposeBag()

    func doKakaoSyn(arrSpeaker: [String], arrContent: [String], index: Int) {
        
        fileURL = UtilFile.getFileURL(dirname: arrTTSPlatform[ttsPlatformType.rawValue], basename: arrSpeaker[index])
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL?.path ?? "") {
            if DEBUG_MODE {
                Util.movePlayList(vc: uvc ?? UIViewController(), dirname: arrTTSPlatform[ttsPlatformType.rawValue])
            }
            else {
                UtilAudio.playMP3(uvc: uvc as! AVAudioPlayerDelegate, fileURL: fileURL!)
            }
        }
        else {
//            let speaker = arrSpeaker[index]
            let content = arrContent[index]
            downloadKakao(content: content)
        }
    }
    
    func doKakaoRec(fileURL: URL) {
        
        UtilFile.checkFileURL(url: fileURL)
        
        // temp_code
        if false {//DEBUG_MODE {
            UtilAudio.playMP3(uvc: uvc as! AVAudioPlayerDelegate, fileURL: fileURL)

        }
        else {
            let content = UtilFile.readFile(fileURL: fileURL)
            uploadKakaoRec(content: content)
        }
    }
    
    func uploadKakaoRec(content: Data) {
        
        let header = APIParameter.getKakaoSTTHeaderItem()
        
        guard let url = APIParameter.postKakaoRec(content: content, header: header) else{
            return
        }
        
        //        LoadingHUD.show()
        APIService.request(urlrequest: url)
            //            .filter{AppServiceErrorCode.checkData(vc: self, data: $0)}
            .subscribe(onNext: {
                [weak self] data in
                
                print("data : \(String(decoding: data, as: UTF8.self))")
                
                let dataJson = JSON(data)
                let message = dataJson["msg"].string

                if message?.isEmpty ?? true {
                
                    let message = dataJson["text"].string ?? "임시값"
                    Util.displayPopup(uvc: self?.uvc ?? UIViewController(), title: "Success", message: message ?? "텍스트 변환 성공")

                }
                else {
                    // popup
                    let message = dataJson["msg"].string ?? "에러발생"
                    Util.displayPopup(uvc: self?.uvc ?? UIViewController(), title: "Error", message: message)
                    
                }
                
                },onError: {
                    error in
                    
            },onCompleted: {
                //                    LoadingHUD.hide()
            }).disposed(by: self.disposeBag)
    }
    
    func downloadKakao(content: String) {
        
        print("downloadKakao content: \(content)")
        let header = APIParameter.getKakaoTTSHeaderItem()
        guard let url = APIParameter.postKakaoSyn(content: content, header: header) else{
            return
        }
        
        //        LoadingHUD.show()
        APIService.request(urlrequest: url)
            //            .filter{AppServiceErrorCode.checkData(vc: self, data: $0)}
            .subscribe(onNext: {
                [weak self] data in
                
                print("data : \(String(decoding: data, as: UTF8.self))")
                
                let dataJson = JSON(data)
                let message = dataJson["msg"].string

                if message?.isEmpty ?? true {
                    // 입력데이타를 파일로 저장
                    UtilFile.writeFile(fileURL: (self?.fileURL)!, data: data)

                    
                    if DEBUG_MODE {
                        // move to vc of mp3 list
                        Util.movePlayList(vc: self?.uvc ?? UIViewController(), dirname: arrTTSPlatform[ttsPlatformType.rawValue])
                    }
                    else {
                        // play mp3
                        UtilAudio.playMP3(uvc: self?.uvc as! AVAudioPlayerDelegate, fileURL: (self?.fileURL)!)
                    }
                    
                }
                else {
                    // popup
                    let message = dataJson["msg"].string ?? "에러발생"
                    Util.displayPopup(uvc: self?.uvc ?? UIViewController(), title: "Error", message: message)
                    
                }
                
                },onError: {
                    error in
                    
            },onCompleted: {
                //                    LoadingHUD.hide()
            }).disposed(by: self.disposeBag)
        
    }
    
}
