//
//  Util.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class Util {
    

    static func displayPopup(uvc: UIViewController, title: String, message: String) {
        
        let popup = PopupDialog(title: title, message: message)
        let btnOK = DefaultButton(title: "OK", action: nil)
        
        uvc.present(popup, animated: true, completion: nil)
    }
    
    static func getCurrentDate() -> String {
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        var current_date_string = formatter.string(from: Date())
        return current_date_string
    }
    
    static func moveSTT(vc: UIViewController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "STTVC") as? STTVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            vc.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
    static func moveRecorite(vc: UIViewController, index: Int, dirname: String) {
        
        let dirURL = UtilFile.getDirURL(dirname: dirname)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "RecordListVC") as? RecordListVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            sttPlatformType = STTPlatformType(rawValue: index) ?? STTPlatformType.NAVER_CSR
            uvc.dirURL = dirURL
            vc.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
    static func moveTTS(vc: UIViewController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "TTSVC") as? TTSVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            vc.navigationController?.pushViewController(uvc, animated: true)
        }
    }

    static func moveTextList(vc: UIViewController, index: Int) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "TextListVC") as? TextListVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            ttsPlatformType = TTSPlatformType(rawValue: index) ?? TTSPlatformType.NAVER_CSS
            vc.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
    static func movePlayList(vc: UIViewController, dirname: String) {
        
        let dirURL = UtilFile.getDirURL(dirname: dirname)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "PlayListVC") as? PlayListVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            uvc.dirURL = dirURL
            vc.navigationController?.pushViewController(uvc, animated: true)
        }
    }
    
}
