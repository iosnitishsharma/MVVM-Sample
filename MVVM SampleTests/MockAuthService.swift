//
//  MockAuthService.swift
//  MVVM Sample
//
//  Created by Juani on 11/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import SwiftyJSON
@testable import MVVM_Sample

class MockAuthService : NSObject, AuthService {
    
    var simulateNetworkError = false
    
    func login(user:User) -> SignalProducer<JSON, NSError> {

        //if let jsonData:AnyObject = User.encode(user) {
            
        return SignalProducer { observer, disposable in
            
            if self.simulateNetworkError {
                observer.sendFailed(NSError(domain: "test", code: 1, userInfo: nil))
                
            } else {
                
                let validLogin = user.username == "juani" && user.password == "123"
                if validLogin {
                    
                    user.password = ""
                    let jsonResponse = JSON(User.encode(user))
                    observer.sendNext(jsonResponse)
                    observer.sendCompleted()
                    
                } else {
                    
                    var errorResponse = [String: AnyObject]()
                    errorResponse["errorCode"] = "1"
                    let jsonResponse = JSON(errorResponse)
                    observer.sendNext(jsonResponse)
                    observer.sendCompleted()
                    
                }
                
            }
        }
        
        //                disposable.addDisposable {
        //                    task.cancel()
        //                }
        //                task.resume()
    }
    
    

    
    


}