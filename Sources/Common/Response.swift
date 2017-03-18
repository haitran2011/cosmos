//
//  Response.swift
//  MilkyChat
//
//  Created by Tue Nguyen on 5/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper

enum ResponseStatus: String {
    case Success = "success"
    case Error = "error"
}

class BaseResponse: Mappable  {
//    var status: ResponseStatus?
    var errorCode: Int?
    var errorMessage: String?
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
//        status <- map["status"]
        errorCode <- map["code"]
        errorMessage <- map["message"]
    }
}
