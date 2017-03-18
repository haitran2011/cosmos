//
//  VideoDetailItem.swift
//  cosmos
//
//  Created by HieuiOS on 3/2/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftDate
import RealmSwift

class VideoDetailItem: Object, Mappable{
    dynamic var title: String? = ""
    dynamic var deScription: String? = ""
    dynamic var thumbnail: String? = ""
    dynamic var videoID: String? = ""
    dynamic var publishedAt: Date? = nil
    dynamic var duration: String? = ""
    dynamic var viewCount: String? = "0"
    dynamic var likeCount: String? = "0"
    dynamic var favoriteCount: String? = "0"
    dynamic var dislikeCount: String? = "0"
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title <- map["snippet.title"]
        deScription <- map["snippet.description"]
        thumbnail <- map["snippet.thumbnails.maxres.url"]
        videoID <- map["id"]
        duration <- map["contentDetails.duration"]
        viewCount <- map["statistics.viewCount"]
        likeCount <- map["statistics.likeCount"]
        dislikeCount <- map["statistics.dislikeCount"]
        favoriteCount <- map["statistics.favoriteCount"]
        let dateFormatter = DateFormatter()
        let iso8601Formatter = ISO8601DateTimeFormatter()
        iso8601Formatter.formatOptions = .withInternetDateTimeExtended
        dateFormatter.dateFormat = iso8601Formatter.formatterString
        let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)
        publishedAt <- (map["snippet.publishedAt"],dateTransform)
    }
}
