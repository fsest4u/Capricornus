//
//  TTSVC.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import SwiftyJSON
import Alamofire

class TTSVC: UIViewController, AVAudioPlayerDelegate {
    
    var indexRow = 0
    
    var fileURL: URL?

    var arrTitle: [String] = []
    var arrSpeaker: [String] = []
    var arrContent: [String] = []
    
    var naver = Naver()
    var kakao = Kakao()
    var google = Google()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("TTSVC platformType : \(platformType)")
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
        case PlatformType.NAVER_CSR:
            print("NAVER_CSR")
        case PlatformType.NAVER_CSS:
            naver.uvc = self
            arrTitle = arrNaverCSSTitle
            arrSpeaker = arrNaverCSSSpeaker
            arrContent = arrNaverCSSContent
            
        case PlatformType.NAVER_CPV:
            naver.uvc = self
            arrTitle = arrNaverCPVTitle
            arrSpeaker = arrNaverCPVSpeaker
            arrContent = arrNaverCPVContent
            
        case PlatformType.KAKAO:
            kakao.uvc = self
            arrTitle = arrKakaoTitle
            arrSpeaker = arrKakaoTitle
            arrContent = arrKakaoContent
        case PlatformType.GOOGLE:
            google.uvc = self
            arrTitle = arrGoogleTitle
            arrSpeaker = arrGoogleTitle
            arrContent = arrGoogleContent
        default:
            break
        }
    }

    
    
}

extension TTSVC: UITableViewDelegate, UITableViewDataSource {
    
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
        case PlatformType.NAVER_CSR:
            print("NAVER_CSR")
        case PlatformType.NAVER_CSS:
            naver.doNaverCSS(arrSpeaker: arrSpeaker, arrContent: arrContent, index: indexRow)
            
        case PlatformType.NAVER_CPV:
            naver.doNaverCPV(arrSpeaker: arrSpeaker, arrContent: arrContent, index: indexRow)
            
        case PlatformType.KAKAO:
            kakao.doKakao(arrSpeaker: arrSpeaker, arrContent: arrContent, index: indexRow)
            
        case PlatformType.GOOGLE:
            google.doGoogle(arrSpeaker: arrSpeaker, arrContent: arrContent, index: indexRow)
            
        case PlatformType.AWS:
            print("type AWS")
            
//        case PlatformType.MICROSOFT:
//            print("type MICROSOFT")
//
//        case PlatformType.IBM:
//            print("type IBM")
//
//        default:
//            print("type NONE")
            
        }
    }
    
    
}

class SpeechCell: UITableViewCell {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
}
