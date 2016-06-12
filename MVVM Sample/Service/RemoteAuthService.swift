//
//  AuthService.swift
//  MVVM Sample
//
//  Created by Juani on 10/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import SwiftyJSON

class RemoteAuthService : NSObject, AuthService {
    
    let host = "http://localhost:9955/AuthService/"
    
    private func requestWithBody(path: String, method: String, body: JSON) -> Result<NSMutableURLRequest, NSError> {
        let request : NSMutableURLRequest = NSMutableURLRequest()
        
        request.URL = NSURL(string: host + path)
        request.HTTPMethod = method
        if method == "POST" {
            do {
                request.HTTPBody = try body.rawData(options: .PrettyPrinted)
            } catch let error as NSError {
                return Result(error: error)
            }
        }
        
        return Result(request)
    }

    
    func login(user:User) -> SignalProducer<JSON, NSError> {
        
        if let jsonData:AnyObject = User.encode(user) {
            let requestResult = self.requestWithBody("login", method: "POST", body: JSON(jsonData))
            if let requestResultValue = requestResult.value {
                return NSURLSession.sharedSession().rac_dataWithRequest(requestResultValue)
                    .map { data, URLResponse in
                        return JSON.parse( String(data: data, encoding: NSUTF8StringEncoding) ?? "" )
                }
            }
        }
        fatalError("jsonData is nil")
        
    }
    
    
}