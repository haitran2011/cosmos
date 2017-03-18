//
//  BaseError.swift
//  MilkyChat
//
//  Created by Thanh Nguyen on 12/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation

class BaseError {
    var code: Int!
    var errorMessage: String!
    
    init(code errCode:Int, message:String) {
        code = errCode
        errorMessage = message
    }
    
    init(error: NSError) {
        code = error.code
        errorMessage = error.localizedDescription
    }
}

class ServiceError: BaseError {
    
}
