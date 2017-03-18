//
//  CollectionViewFooter.swift
//  cosmos
//
//  Created by HieuiOS on 2/22/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

extension CollectionViewFooter: Reusable { }
extension CollectionViewFooter: NibLoadable { }

class CollectionViewFooter: UICollectionReusableView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.color = ColorSchema.appTheme()
    }
    func setup(for state: LoadingState) {
        if state == LoadingState.loaded {
            label.isHidden = true
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }else if state == LoadingState.error || state == LoadingState.noData {
            indicatorView.stopAnimating()
            label.isHidden = false
            indicatorView.isHidden = true
            label.text = state.descriptionString()
        } else {
            label.isHidden = true
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        }
        
    }
}
