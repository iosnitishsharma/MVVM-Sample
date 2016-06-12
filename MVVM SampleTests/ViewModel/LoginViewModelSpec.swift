//
//  LoginViewModelSpec.swift
//  MVVM Sample
//
//  Created by Juani on 11/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Quick
import Nimble
import ReactiveCocoa
import Result
import SwiftyJSON
@testable import MVVM_Sample



class LoginViewModelSpec: QuickSpec {
    override func spec() {
        describe("LoginViewModel") {
            var mockAuthService: MockAuthService!
            var loginViewModel: LoginViewModel!
            
            beforeEach {
                mockAuthService = MockAuthService()
                loginViewModel = LoginViewModel(authService:mockAuthService)
            }
            
            it("initially has empty fields") {
                expect(loginViewModel.userName.value).to(equal(""))
                expect(loginViewModel.password.value).to(equal(""))
            }
            
            context("when has invalid UI input") {
                beforeEach {
                    loginViewModel.resetUIValues()
                }
                
                it("has empty password") {
                    
                    loginViewModel.userName.value = "juani"
                    loginViewModel.password.value = ""
                    
                    expect(loginViewModel.inputIsValid.value).to(beFalse())
                    
                }
                
                it("has empty username") {
                    
                    loginViewModel.userName.value = ""
                    loginViewModel.password.value = "123"
                    
                    expect(loginViewModel.inputIsValid.value).to(beFalse())
                    
                }
                
                
            }
            
            context("when calling a login action") {
                beforeEach {
                    loginViewModel.resetUIValues()
                }
                
                it("has the right credentials") {
                    
                    loginViewModel.userName.value = "juani"
                    loginViewModel.password.value = "123"
                    
                    var loginSuccessfully = false
                    loginViewModel.loginAction.apply().startWithNext({ (success) in
                        loginSuccessfully = success
                    })
                    expect(loginSuccessfully).to(beTrue())
                    expect(loginViewModel.errorMessage.value).to(equal(""))
                    
                    
                }
                
                
                
                it("has wrong credentials") {
                    
                    loginViewModel.userName.value = "juani"
                    loginViewModel.password.value = "122222"
                    
                    var loginSuccessfully = true
                    loginViewModel.loginAction.apply().startWithNext({ (success) in
                        loginSuccessfully = success
                    })
                    expect(loginSuccessfully).to(beFalse())
                    expect(loginViewModel.errorMessage.value).to(contain("Localized LOGIN error for code"))
                    
                }
                
            }
            context("when network is down") {
                beforeEach {
                    (loginViewModel.authService as! MockAuthService).simulateNetworkError = true
                    loginViewModel.resetUIValues()
                }
                
                afterEach {
                    (loginViewModel.authService as! MockAuthService).simulateNetworkError = false
                }
                
                it("has the right credentials but network is down") {
                    
                    loginViewModel.userName.value = "juani"
                    loginViewModel.password.value = "123"
                    
                    var loginSuccessfully = true
                    loginViewModel.loginAction.apply().startWithFailed({ (error) in
                        loginSuccessfully = false
                    })
                    expect(loginSuccessfully).to(beFalse())
                    expect(loginViewModel.errorMessage.value).to(contain("Localized NETWORK error for code"))
                    
                }
                
                
            }
            
            
            
            
      
        }
    }
}
