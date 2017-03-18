//
//  Location.swift
//  cosmos
//
//  Created by Tue Nguyen on 5/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Mappable {
    var id: Int!
    var restaurantId: Int!
    var name: String!
    var phone: String!
    var address: String!
    var createdAt: Date!
    var updatedAt: Date!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)
        
        id <- map["id"]
        restaurantId <- map["restaurant_id"]
        name <- map["name"]
        address <- map["address"]
        createdAt <- (map["created_at"], dateTransform)
        updatedAt <- (map["updated_at"], dateTransform)
    }
    
}
