//
//  SearchVideoItem.swift
//  cosmos
//
//  Created by HieuiOS on 3/3/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchVideoItem: Mappable {
    var videoID: String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        videoID <- map["id.videoId"]
    }
}
