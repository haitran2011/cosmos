//
//  VideoItem.swift
//  cosmos
//
//  Created by HieuiOS on 2/17/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoItem: Mappable{
    var videoID: String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        videoID <- map["contentDetails.videoId"]
    }
}
