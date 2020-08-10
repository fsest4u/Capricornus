//
//  ViewController.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit
import PopupDialog

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick_BtnSTT(_ sender: UIButton) {
//        print("onClick_BtnSTT")
        Util.displayPopup(uvc: self, title: "안내", message: "준비 중입니다.")
        
    }
    
    @IBAction func onClick_BtnTTS(_ sender: UIButton) {
        print("onClick_BtnTTS")
        Util.moveTTS(vc: self)

    }
    
}
