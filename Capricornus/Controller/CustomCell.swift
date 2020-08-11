//
//  CustomCell.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/10.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import UIKit

class PlayListCell: UITableViewCell {
    
    @IBOutlet weak var labelFileName: UILabel!
    
}

class SpeechCell: UITableViewCell {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
}

class PlatformCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPlatform: UIImageView!
    @IBOutlet weak var labelPlatform: UILabel!
}
