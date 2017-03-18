//
//  ListPlayGridCell.swift
//  cosmos
//
//  Created by HieuiOS on 2/8/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

extension ListPlayGridCell : Reusable { }
extension ListPlayGridCell : NibLoadable { }

class ListPlayGridCell: UICollectionViewCell {
    @IBOutlet weak var imageHeighConstraint: NSLayoutConstraint!
 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelVideoCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(with playlistItem: PlayListItem?) -> Void {
        if let thumbnail = playlistItem?.thumbnail{
            imageView.kf.setImage(with: URL(string: thumbnail), placeholder: #imageLiteral(resourceName: "noImageBig"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        if let count = playlistItem?.itemCount{
            labelVideoCount.text = "\(count)"
        }else{
            labelVideoCount.text = ""
        }
        labelTitle.text = playlistItem?.title
        if let createDate = playlistItem?.publishedAt {
            //labelDate.text = DateTimeHelper.relativePast(for: createDate)
            labelDate.text = DateFormatterHelper.dateStringInTimeline(DateInRegion(absoluteDate: createDate))
    
        } else {
            labelDate.text = "--"
        }
    }
    
}
