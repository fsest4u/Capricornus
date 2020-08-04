//
//  SpeechVC.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit

class SpeechVC: UIViewController {

    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("SpeechVC index : \(index)")
        initPlatform(index: PlatformType(rawValue: index) ?? PlatformType.NAVER)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func initPlatform(index: PlatformType = PlatformType.NAVER) {
        
        switch index {
            case PlatformType.NAVER:
                print("type NAVER")
            
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

extension SpeechVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SpeechCell = tableView.dequeueReusableCell(withIdentifier: "SpeechCell", for: indexPath) as! SpeechCell
        
        cell.labelContent.text = arrContent[indexPath.row]
        
        return cell
    }
    
    
}

class SpeechCell: UITableViewCell {
    
    @IBOutlet weak var labelContent: UILabel!
    
}
