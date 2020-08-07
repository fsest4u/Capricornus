//
//  Google.swift
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


class Google {
    
    var uvc: UIViewController?
    var fileURL: URL?

    var disposeBag = DisposeBag()

    func doGoogle(arrSpeaker: [String], arrContent: [String], index: Int) {
        
        fileURL = Util.getFileURL(dirname: arrPlatform[platformType.rawValue], basename: arrSpeaker[index])
        let fileManager = FileManager.default
        print("doGoogle: \(fileURL?.path)")
        if fileManager.fileExists(atPath: fileURL?.path ?? "") {
            if DEBUG_MODE {
                Util.moveMP3List(vc: uvc ?? UIViewController(), dirname: arrPlatform[platformType.rawValue])
            }
            else {
                Util.playMP3(uvc: uvc as! AVAudioPlayerDelegate, fileURL: fileURL!)
            }
        }
        else {
//            let speaker = arrSpeaker[index]
            let content = arrContent[index]
            downloadGoogle(content: content)
        }
    }
    
    func downloadGoogle(content: String) {
        
        print("downloadGoogle content: \(content)")
        let header = APIParameter.getGoogleHeaderItem()
        guard let url = APIParameter.postGoogle(content: content, header: header) else{
            return
        }
        
        //        LoadingHUD.show()
        APIService.request(urlrequest: url)
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
                //                    LoadingHUD.hide()
            }).disposed(by: self.disposeBag)
        
    }
    
}
