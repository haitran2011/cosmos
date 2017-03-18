//
//  Restaurant.swift
//  cosmos
//
//  Created by Tue Nguyen on 5/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper

class Restaurant: Mappable {
    var id: Int!
    var name: String!
    var phoneNumber: String!
    var email: String!
    var tags: [String]!
    var locations: [Location]!
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phoneNumber <- map["phone_number"]
        email <- map["email"]
        tags <- map["tags"]
        locations <- map["locations"]
    }
}
