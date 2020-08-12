//
//  APIParameter.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import Alamofire

class APIParameter {
    
    // Base Query Item
    static func getBaseQueryItem() -> [NSURLQueryItem] {
                
        var queryItems = [NSURLQueryItem]()
        
//        queryItems.append(NSURLQueryItem(name: PARAM_NAME_CONTENT_TYPE, value:  PARAM_VALUE_CONTENT_TYPE))
//        queryItems.append(NSURLQueryItem(name: PARAM_NAME_API_ID, value:  PARAM_VALUE_CLIENT_ID))
//        queryItems.append(NSURLQueryItem(name: PARAM_NAME_API_KEY, value:  PARAM_VALUE_CLIENT_SECRET))
        
        return queryItems
        
    }

    static func getNaverTTSHeaderItem() -> Dictionary<String, String> {
                
        var header: [String: String] = Dictionary<String, String>()
        
        header[PARAM_NAME_NAVER_CONTENT_TYPE] = PARAM_VALUE_NAVER_TTS_CONTENT_TYPE
        header[PARAM_NAME_NAVER_API_ID] = PARAM_VALUE_NAVER_CLIENT_ID
        header[PARAM_NAME_NAVER_API_KEY] = PARAM_VALUE_NAVER_CLIENT_SECRET
          
        return header
        
    }
    
    static func getNaverSTTHeaderItem() -> Dictionary<String, String> {
                
        var header: [String: String] = Dictionary<String, String>()
        
        header[PARAM_NAME_NAVER_CONTENT_TYPE] = PARAM_VALUE_NAVER_STT_CONTENT_TYPE
        header[PARAM_NAME_NAVER_API_ID] = PARAM_VALUE_NAVER_CLIENT_ID
        header[PARAM_NAME_NAVER_API_KEY] = PARAM_VALUE_NAVER_CLIENT_SECRET
          
        return header
        
    }

    static func getKakaoTTSHeaderItem() -> Dictionary<String, String> {
                
        var header: [String: String] = Dictionary<String, String>()
        
        header[PARAM_NAME_KAKAO_CONTENT_TYPE] = PARAM_VALUE_KAKAO_TTS_CONTENT_TYPE
        header[PARAM_NAME_KAKAO_AUTHORIZATION] = PARAM_VALUE_KAKAO_AUTHORIZATION
          
        return header
        
    }
    
    static func getKakaoSTTHeaderItem() -> Dictionary<String, String> {
                
        var header: [String: String] = Dictionary<String, String>()
        
        header[PARAM_NAME_KAKAO_CONTENT_TYPE] = PARAM_VALUE_KAKAO_TTS_CONTENT_TYPE
        header[PARAM_NAME_KAKAO_AUTHORIZATION] = PARAM_VALUE_KAKAO_AUTHORIZATION
        header[PARAM_NAME_KAKAO_ENCODING] = PARAM_VALUE_KAKAO_ENCODING
          
        return header
        
    }
    
    static func getGoogleHeaderItem() -> Dictionary<String, String> {
                
        var header: [String: String] = Dictionary<String, String>()
        
        header[PARAM_NAME_GOOGLE_CONTENT_TYPE] = PARAM_VALUE_GOOGLE_CONTENT_TYPE
        header[PARAM_NAME_GOOGLE_AUTHORIZATION] = PARAM_VALUE_GOOGLE_AUTHORIZATION
          
        return header
        
    }

    static func postNaverCSS(content: String, speaker: String, speed: Int) -> Dictionary<String, Any> {
        
        var param : [String : Any] = Dictionary<String, Any>()
        
        let queryItems = getBaseQueryItem()
        let count = queryItems.count
        for i in 0..<count {
            param[queryItems[i].name] = queryItems[i].value
        }
        param[PARAM_NAME_NAVER_TEXT] = content
        param[PARAM_NAME_NAVER_SPEAKER] = speaker
        param[PARAM_NAME_NAVER_SPEED] = speed
        
        return param
    }
    
    static func postNaverCPV(content: String, speaker: String, speed: Int, volume: Int, pitch: Int, emotion: Int, format: String) -> Dictionary<String, Any> {
        
        var param : [String : Any] = Dictionary<String, Any>()
        
        let queryItems = getBaseQueryItem()
        let count = queryItems.count
        for i in 0..<count {
            param[queryItems[i].name] = queryItems[i].value
        }
        param[PARAM_NAME_NAVER_TEXT] = content
        param[PARAM_NAME_NAVER_SPEAKER] = speaker
        param[PARAM_NAME_NAVER_SPEED] = speed
        param[PARAM_NAME_NAVER_VOLUME] = volume
        param[PARAM_NAME_NAVER_PITCH] = pitch
        param[PARAM_NAME_NAVER_EMOTION] = emotion
        param[PARAM_NAME_NAVER_FORMAT] = format

        return param
    }
    
    static func postNaverCSR(content: Data, header: HTTPHeaders) -> URLRequest? {
        
        var queryItems = getBaseQueryItem()

        queryItems.append(NSURLQueryItem(name: PARAM_NAME_NAVER_LANG, value: PARAM_VALUE_NAVER_LANG))

        guard let urlComps = NSURLComponents(string: API_PATH_NAVER_HOST + API_PATH_NAVER_CSR) else {
            return nil
        }
        
        urlComps.queryItems = queryItems as [URLQueryItem]
//        urlComps.replacingPlus()
        
        guard let url = urlComps.url else{
            return nil
            
        }
        var request: URLRequest?
        do {
            request = try URLRequest(url: url, method: .post, headers: header)
//            request?.httpMethod = "POST"
//            request?.httpBody = content.data(using: .utf8)
            request?.httpBody = content
        }
        catch {
            print("Error postKakao URLRequest")
        }

        
        return request
    }
    
//    static func postKakao(content: String) -> Dictionary<String, Any> {
//
//        var param : [String : Any] = Dictionary<String, Any>()
//
//        let queryItems = getBaseQueryItem()
//        let count = queryItems.count
//        for i in 0..<count {
//            param[queryItems[i].name] = queryItems[i].value
//        }
//        param[""] = content
//
//        return param
//    }
    
    static func postKakaoSyn(content: String, header: HTTPHeaders) -> URLRequest? {
        
        var queryItems = getBaseQueryItem()

        guard let urlComps = NSURLComponents(string: API_PATH_KAKAO_HOST + API_PATH_KAKAO_SYN) else {
            return nil
        }
        
        urlComps.queryItems = queryItems as [URLQueryItem]
//        urlComps.replacingPlus()
        
        guard let url = urlComps.url else{
            return nil
            
        }
        var request: URLRequest?
        do {
            request = try URLRequest(url: url, method: .post, headers: header)
//            request?.httpMethod = "POST"
            request?.httpBody = content.data(using: .utf8)
        }
        catch {
            print("Error postKakao URLRequest")
        }

        
        return request
    }
    
    static func postKakaoRec(content: Data, header: HTTPHeaders) -> URLRequest? {
            
        var queryItems = getBaseQueryItem()

//        queryItems.append(NSURLQueryItem(name: PARAM_NAME_NAVER_LANG, value: PARAM_VALUE_NAVER_LANG))

        guard let urlComps = NSURLComponents(string: API_PATH_KAKAO_HOST + API_PATH_KAKAO_REC) else {
            return nil
        }
        
        urlComps.queryItems = queryItems as [URLQueryItem]
//        urlComps.replacingPlus()
        
        guard let url = urlComps.url else{
            return nil
            
        }
        var request: URLRequest?
        do {
            request = try URLRequest(url: url, method: .post, headers: header)
//            request?.httpMethod = "POST"
//            request?.httpBody = content.data(using: .utf8)
            request?.httpBody = content
        }
        catch {
            print("Error postKakao URLRequest")
        }

        
        return request
    }
    
    static func postGoogle(content: String, header: HTTPHeaders) -> URLRequest? {
            
            var queryItems = getBaseQueryItem()

            guard let urlComps = NSURLComponents(string: API_PATH_GOOGLE_HOST + API_PATH_GOOGLE_SYN) else {
                return nil
            }
            
            urlComps.queryItems = queryItems as [URLQueryItem]
    //        urlComps.replacingPlus()
            
            guard let url = urlComps.url else{
                return nil
                
            }
            var request: URLRequest?
            do {
                request = try URLRequest(url: url, method: .post, headers: header)
    //            request?.httpMethod = "POST"
                request?.httpBody = content.data(using: .utf8)
            }
            catch {
                print("Error postGoogle URLRequest")
            }

            
            return request
        }
}
