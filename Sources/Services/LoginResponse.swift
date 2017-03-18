//
//  LoginResponse.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: BaseResponse {
    var id: Int!
    var email: String?
    var apiKey: String!
    var restaurant: Restaurant!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["result.id"]
        email <- map["result.email"]
        apiKey <- map["result.api_key"]
        restaurant <- map["result.restaurant_info"]
    }
}
