//
//  APIParameter.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation

class APIParameter {
    
    // Base Query Item
    static func getBaseQueryItem() -> [NSURLQueryItem] {
                
        var queryItems = [NSURLQueryItem]()
        
        queryItems.append(NSURLQueryItem(name: PARAM_NAME_CONTENT_TYPE, value:  PARAM_VALUE_CONTENT_TYPE))
        queryItems.append(NSURLQueryItem(name: PARAM_NAME_API_ID, value:  PARAM_VALUE_CLIENT_ID))
        queryItems.append(NSURLQueryItem(name: PARAM_NAME_API_KEY, value:  PARAM_VALUE_CLIENT_SECRET))
        
        return queryItems
        
    }

    static func getHeaderItem() -> Dictionary<String, String> {
                
        var header: [String: String] = Dictionary<String, String>()
        
        header[PARAM_NAME_CONTENT_TYPE] = PARAM_VALUE_CONTENT_TYPE
        header[PARAM_NAME_API_ID] = PARAM_VALUE_CLIENT_ID
        header[PARAM_NAME_API_KEY] = PARAM_VALUE_CLIENT_SECRET
          
        return header
        
    }
    
    static func postNaverCSS(speaker: String, speed: String, content: String) -> Dictionary<String, Any> {
        
        var param : [String : Any] = Dictionary<String, Any>()
        
        let queryItems = getBaseQueryItem()
        let count = queryItems.count
        for i in 0..<count {
            param[queryItems[i].name] = queryItems[i].value
        }
        param[PARAM_NAME_SPEAKER] = speaker
        param[PARAM_NAME_SPEED] = speed
        param[PARAM_NAME_TEXT] = content
        
        return param
    }
    
    
}
