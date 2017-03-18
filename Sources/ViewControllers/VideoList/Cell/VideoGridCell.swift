//
//  VideoGridCell.swift
//  cosmos
//
//  Created by HieuiOS on 2/23/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import SwiftDate

extension VideoGridCell: NibLoadable { }
extension VideoGridCell: Reusable {}

class VideoGridCell: UICollectionViewCell {
    
    @IBOutlet weak var imageHeighConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelViewCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.makeBorderWidth(boderWidth: 1 / UIScreen.main.scale)
        imageView.makeBorderColor(borderColor: UIColor(red: 219/255.0, green: 219/255.0, blue: 219/255.0, alpha: 1))
    }
    func setupCell(with videoItem: VideoDetailItem?) -> Void {
        if let thumbnail = videoItem?.thumbnail{
            imageView.kf.setImage(with: URL(string: thumbnail), placeholder: #imageLiteral(resourceName: "noImageBig"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        labelTitle.text = videoItem?.title
        if let viewCount = videoItem?.viewCount{
            labelViewCount.text = "\(viewCount) lượt xem"
        }else{
            labelViewCount.text = "0 lượt xem"
        }
        if let createDate = videoItem?.publishedAt {
            labelDate.text = DateTimeHelper.relativePast(for: createDate)
//            labelDate.text = DateFormatterHelper.dateStringInTimeline(DateInRegion(absoluteDate: createDate))            
        } else {
            labelDate.text = "--"
        }
    }
}
