//
//  Util.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation

class Util {
    
    
    
    static func getCurrentDate() -> String {
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        var current_date_string = formatter.string(from: Date())
        return current_date_string
    }
}
