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

protocol AuthService {
    
    func login(user:User) -> SignalProducer<JSON, NSError>
    
}