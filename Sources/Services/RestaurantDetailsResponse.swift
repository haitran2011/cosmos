//
//  RestaurantDetailsResponse.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/7/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper

class RestaurantDetailsResponse: BaseResponse {
    var result:Restaurant?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        result <- map["result"]
        
        
    }
}
