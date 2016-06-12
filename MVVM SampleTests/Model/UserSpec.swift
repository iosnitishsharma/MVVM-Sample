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

class UserSpec: QuickSpec {
    
    override func spec() {
        describe("A User") {
            it("is valid user when decoded from a json string") {
                
                var validUserJSON = [String: AnyObject]()
                validUserJSON["username"] = "juani"
                let validUser = User.decode(JSON(validUserJSON))
                
                let invalidUserJSON = [String: AnyObject]()
                let invalidUser = User.decode(JSON(invalidUserJSON))

                expect(validUser.isValid()).to(beTrue())
                expect(invalidUser.isValid()).to(beFalse())
                
            }
            
        }
    }
}
