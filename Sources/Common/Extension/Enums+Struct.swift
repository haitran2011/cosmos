//
//  FilterEnums.swift
//  BrickInUp
//
//  Created by Hieu Trinh on 10/12/16.
//  Copyright © 2016 Vince Tran. All rights reserved.
//

import Foundation
import UIKit

enum SearchType: StringLiteralType{
    case channel = "chanel"
    case playlist = "playlist"
    case video = "video"
}

enum OrderSearchType: StringLiteralType{
    case date = "date"
    case rating = "rating"
    case relevance = "relevance"
    case title = "title"
    case videoCount = "videoCount"
    case viewCount = "viewCount"
}

enum InforType:Int {
    case unkown = -1
    case firstname = 0
    case lastname
    case phonenumber
    case email
    case other
    func descriptionString() -> String {
        switch self {
        case .unkown:
            return ""
        case .firstname:
            return "FIRST NAME"
        case .lastname:
            return "LAST NAME"
        case .phonenumber:
            return "PHONE NUMBER"
        case .email:
            return "EMAIL"
        case .other:
            return "OTHER"
        }
    }
    static func allValue() -> [InforType] {
        return [InforType.firstname,InforType.lastname,
                InforType.phonenumber,InforType.email,
                InforType.other]
    }
}

enum ViewType:Int{
    case list = 0
    case grid = 1
}

enum FetchType: Int {
    case refresh = 0
    case loadmore
    case loading
}

enum LoadingState :Int {
    case initial = 0
    case loading
    case refreshing
    case loaded
    case noData
    case error
    
    func descriptionString() -> String {
        switch self {
        case .initial:
            return "Khởi tạo"
        case .loading:
            return "Đang tải..."
        case .refreshing:
            return "Làm mới..."
        case .loaded:
            return "Đã tải"
        case .noData:
            return "Không có dữ liệu"
        case .error:
            return "Xảy ra lỗi, hãy thử lại!"
        }
    }
    
}

