//
//  APIService.swift
//  Capricornus
//
//  Created by spdevapp on 2020/08/05.
//  Copyright © 2020 hyeon. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class APIService {
    
    static func request(urlrequest: URLRequest) -> Observable<Data> {
        var urlRequest =  urlrequest
        urlRequest.timeoutInterval = 10
        return Observable.create { observer -> Disposable in
            Alamofire.request(urlRequest).responseData{
                data in
                
                if let error = data.error{
                    observer.onError(error)
                    
                }else{
                    observer.onNext(data.data!)
                    observer.onCompleted()
                }
                
            }
            return Disposables.create()
            
        }
    }
    
    static func request(index: Int, request: URLRequest) -> Observable<(Int,Data)> {
        
        return Observable.create { observer -> Disposable in
            
            Alamofire.request(request).responseData{
                
                data in
                observer.onNext((index,data.data!))
                observer.onCompleted()
                
            }
            return Disposables.create()
        }
    }
    
    static func request(url: URL, method: HTTPMethod, param: Parameters, header: HTTPHeaders) -> Observable<Data> {
        
        return Observable.create { observer -> Disposable in
            
            Alamofire.request(url.absoluteString, method: method, parameters: param, encoding: URLEncoding.default, headers: header).responseData{
                
                data in
                observer.onNext(data.data!)
                observer.onCompleted()
                
                
            }
            return Disposables.create()
            
        }
    }
    
    static func upload(urlrequest: URLRequest, data: Data, fname: String) -> Observable<Data> {
        
        let host = urlrequest.url?.host ?? ""
        let path = urlrequest.url?.path ?? ""
        
        guard let url = URL(string: "https://" + host + path), let param =  urlrequest.url?.queryParameters else{
            return Observable.create{ _ in return Disposables.create()}
        }
        
        
        
        return Observable.create { observer -> Disposable in
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(data, withName: "image", fileName: fname, mimeType: "image/jpg")
                
                for (key, value) in param {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
            }, to: url, method: .post, headers: nil, encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    case .success(let upload, _, _):
                        print("success")
                        upload.responseJSON { response in
                            
                            observer.onNext(response.data!)
                            observer.onCompleted()
                            
                    }
                    case .failure(let encodingError):
                        print("failure")
                }
                
            })
            
            return Disposables.create()
        }
        
        
    }
    
    static func upload(url: URL, param: Parameters, data: Data, fname: String) -> Observable<Data> {
        
        return Observable.create { observer -> Disposable in
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(data, withName: "image", fileName: fname, mimeType: "image/jpg")
                
                for (key, value) in param {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
            }, to: url, method: .post, headers: nil, encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    case .success(let upload, _, _):
                        print("success")
                        upload.responseJSON { response in
                            
                            observer.onNext(response.data!)
                            observer.onCompleted()
                            
                    }
                    case .failure(let encodingError):
                        print("failure")
                }
                
            })
            
            return Disposables.create()
        }
    }
    
}

