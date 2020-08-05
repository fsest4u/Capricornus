//
//  ViewController.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/04.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick_BtnMove(_ sender: Any) {
        

    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrPlatform.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PlatformCell = tableView.dequeueReusableCell(withIdentifier: "PlatformCell", for: indexPath) as! PlatformCell
        
        cell.imageView?.image = UIImage(named: "icon")
        cell.labelPlatform.text = arrPlatform[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let uvc = storyboard.instantiateViewController(withIdentifier: "SpeechVC") as? SpeechVC {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            platformType = PlatformType(rawValue: index) ?? PlatformType.NAVER
            self.navigationController?.pushViewController(uvc, animated: true)
        }
 
    }
    
    
}

class PlatformCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPlatform: UIImageView!
    @IBOutlet weak var labelPlatform: UILabel!
}
