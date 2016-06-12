//
//  LoginViewModel.swift
//  MVVM Sample
//
//  Created by Juani on 10/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import SwiftyJSON

class LoginViewModel: NSObject {

    let userName = MutableProperty<String>("")
    let password = MutableProperty<String>("")
    let errorMessage = MutableProperty<String>("")
    let inputIsValid = MutableProperty<Bool>(false)
    
    let authService : AuthService
    
    lazy var loginAction: Action<Void, Bool, NSError> = { [unowned self] in
        return Action(enabledIf: self.inputIsValid, { _ in
            
            let loginSignal  : SignalProducer<JSON, NSError> =
                
                self.authService.login(User(username:self.userName.value, password:self.password.value))
            
            return loginSignal.map({ (json) -> Bool in
                
                let currentUser = User.decode(json)
                
                if currentUser.isValid() {
                  self.errorMessage.value = ""
                    
                    // set here local current user here
                    
                  return true
                    
                } else {
                    let code = json["errorCode"].intValue
                    self.errorMessage.value =  "Localized LOGIN error for code: \(code) try juani/123"
                    
                    return false
                }
            })
            
        })
    }()
    
    
    init(authService:AuthService) {

        self.authService = authService
        super.init()
        
        self.resetUIValues()
        
        self.inputIsValid <~ combineLatest(userName.producer, password.producer)
            .map { (userName, password) in
                return !userName.isEmpty && !password.isEmpty
        }
        
        self.loginAction.events.observeNext { [weak self] (event) in
            switch event {
            case let .Failed(error):
                self?.errorMessage.value = "Localized NETWORK error for code: \(error.code). Run the MockRestServlet.rb in your terminal.";
                print("fail")
            default: break
            }
        }
    
    
    }
    
    func resetUIValues() {
        self.userName.value = ""
        self.password.value = ""
        self.errorMessage.value = ""
    }
    
    func viewModeForHomeVC() -> NSObject {
        return "a custom viewModel for HomeVC if needed"
    }



    
    
}
