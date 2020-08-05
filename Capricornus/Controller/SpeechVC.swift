//
//  SpeechVC.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class SpeechVC: UIViewController {
    
    var fileURL: URL?
    
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

    func doNaver(index: Int) {
        
        var speaker = ""
        let speed = "0"
        let content = arrContent[index]
        
        switch index {
            case 0:
                speaker = "mijin"
            case 1:
                speaker = "jingo"
            case 2:
                speaker = "clara"
            case 3:
                speaker = "matt"
            case 4:
                speaker = "meimei"
            default:
                speaker = "mijin"

        }
        
        
//        downloadNaverCSS(speaker: speaker, speed: speed, content: content)
        moveMP3List()
    }
    
    func getDirURL() -> URL {
        
        let fileManager = FileManager.default
        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dirURL = docURL.appendingPathComponent("Naver")
        let dirURLPath = dirURL.path
        
        if !fileManager.fileExists(atPath: dirURLPath) {
            do {
                try fileManager.createDirectory(atPath: dirURLPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create document directory")
            }
        }
        print("getDirURL : \(dirURLPath)")
        return dirURL
    }
    
    func getFileURL() -> URL {

        let dirURL = getDirURL()
        let fileName = Util.getCurrentDate() + ".mp3"
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        return fileURL

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

                // 입력데이타를 파일로 저장
                self?.fileURL = self?.getFileURL()
                print("OKOK : \(self?.fileURL?.absoluteString)")

                do {
                    try data.write(to: (self?.fileURL)!)

                } catch {
                    print("Something went wrong!")
                }
           
                
                },onError: {
                    error in

                    
            },onCompleted: {
                //                LoadingHUD.hide()
                if DEBUG_MODE {
                    // move to vc of mp3 list
                    self.moveMP3List()
                }
                else {
                    // play mp3
                    self.playMP3()
                }
            }).disposed(by: disposebag)
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
    
    func playMP3() {
        
        
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
        
        switch platformType {
            case PlatformType.NAVER:
                
                print("type NAVER")
                doNaver(index: indexPath.row)
            
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
