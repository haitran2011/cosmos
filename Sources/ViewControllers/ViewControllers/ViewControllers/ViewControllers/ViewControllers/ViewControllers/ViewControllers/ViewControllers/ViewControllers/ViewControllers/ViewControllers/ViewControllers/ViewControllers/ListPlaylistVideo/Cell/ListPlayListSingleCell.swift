//
//  ListPlayListSingleCell.swift
//  cosmos
//
//  Created by HieuiOS on 2/8/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

extension ListPlayListSingleCell: Reusable { }
extension ListPlayListSingleCell: NibLoadable { }

class ListPlayListSingleCell: UICollectionViewCell {
    @IBOutlet weak var imageHeighconstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelVideoCount: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        imageView.makeBorderWidth(boderWidth: 0.4)
        imageView.makeBorderColor(borderColor: UIColor(red: 219/255.0, green: 219/255.0, blue: 219/255.0, alpha: 1))
    }
    func setupCell(with playListItem: PlayListItem?){
        if let thumbnail = playListItem?.thumbnail{
            imageView.kf.setImage(with: URL(string: thumbnail), placeholder: #imageLiteral(resourceName: "noImageBig"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        if let count = playListItem?.itemCount{
            labelVideoCount.text = "\(count)"
        }else{
            labelVideoCount.text = ""
        }
        labelTitle.text = playListItem?.title
        if let createDate = playListItem?.publishedAt {
           labelTime.text = DateTimeHelper.relativePast(for: createDate)
//            labelTime.text = DateFormatterHelper.dateStringInTimeline(DateInRegion(absoluteDate: createDate))
        } else {
            labelTime.text = "--"
        }
    }
    
}
