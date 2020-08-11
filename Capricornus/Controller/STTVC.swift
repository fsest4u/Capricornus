//
//  STTVC.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/10.
//  Copyright © 2020 hyeon. All rights reserved.
//

import UIKit

class STTVC: UIViewController {

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

}

extension STTVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSTTPlatform.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlatformCell = tableView.dequeueReusableCell(withIdentifier: "PlatformCell", for: indexPath) as! PlatformCell
        
        cell.imageView?.image = UIImage(named: "icon")
        cell.labelPlatform.text = arrSTTPlatform[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        //temp_code, arrTTSPlatform -> arrSTTPlatform
        Util.moveRecorite(vc: self, index: index, dirname: arrTTSPlatform[index])
    }
}
