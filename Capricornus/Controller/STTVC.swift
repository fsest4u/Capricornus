//
//  STTVC.swift
//  Capricornus
//
//  Created by 이동윤 on 2020/08/07.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit

class STTVC: UIViewController {

    @IBOutlet weak var viewRecord: UIView! {
           
        didSet {
            viewRecord.layer.borderWidth = 0.5
            viewRecord.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
            viewRecord.layer.cornerRadius = (viewRecord.frame.width / 2)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClick_BtnRecord(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            print("start record...")
            
        }
        else {
            print("stop record...")
        }
    }
    
}
