//
//  PlayListItem.swift
//  cosmos
//
//  Created by HieuiOS on 2/13/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftDate

class PlayListItem: Mappable {
    var title: String?
    var description: String?
    var publishedAt: Date?
    var thumbnail: String?
    var itemCount: Int?
    var playlistID: String?
    public required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        title <- map["snippet.title"]
        description <- map["snippet.description"]
        thumbnail <- map["snippet.thumbnails.maxres.url"]
        itemCount <- map["contentDetails.itemCount"]
        playlistID <- map["id"]
        let dateFormatter = DateFormatter()
        let iso8601Formatter = ISO8601DateTimeFormatter()
        iso8601Formatter.formatOptions = .withInternetDateTimeExtended
        dateFormatter.dateFormat = iso8601Formatter.formatterString
        let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)
        publishedAt <- (map["snippet.publishedAt"],dateTransform)
    }
}
