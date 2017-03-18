//
//  VideoResponse.swift
//  cosmos
//
//  Created by HieuiOS on 2/22/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import ObjectMapper

class VideoResponse: BaseResponse {
    var nextPageToken: String?
    var totalResults: Int? = 0
    var resultsPerPage: Int? = 0
    var items:[VideoItem]?
    override func mapping(map: Map) {
        super.mapping(map: map)
        nextPageToken <- map["nextPageToken"]
        totalResults <- map["pageInfo.totalResults"]
        resultsPerPage <- map["pageInfo.resultsPerPage"]
        items <- map["items"]
    }
    
}
