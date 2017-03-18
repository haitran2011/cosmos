//
//  MlkSearchBar.swift
//  MilkyChat
//
//  Created by Thanh Nguyen on 2/28/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

class MlkSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupUI()
    }
    
    func setupUI() {
        
        self.placeholder = "Tìm kiếm".localized()
        self.spellCheckingType = UITextSpellCheckingType.no
        self.autocorrectionType = UITextAutocorrectionType.no
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.barTintColor = ColorSchema.mlkLightGrey()
        
//        self.backgroundImage = UIImage()
        
        if #available(iOS 9.0, *) {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(
                [
                    NSFontAttributeName : UIFont.applicationFont(13),
                    NSForegroundColorAttributeName : ColorSchema.mlkWarmGrey()
                ]
                , for: .normal)
        } else {
            UISearchBar.appearance().tintColor = ColorSchema.mlkWarmGrey()
        }

        let searchField : UITextField = self.value(forKey: "_searchField") as! UITextField
        searchField.borderStyle = .roundedRect
        searchField.layer.borderWidth = 0.5
        searchField.layer.cornerRadius = 15.0
        searchField.layer.masksToBounds = true
        searchField.layer.borderColor = ColorSchema.mlkWhiteTwo().cgColor
        
        if #available(iOS 9.0, *) {
            let attributes = [
                NSForegroundColorAttributeName : ColorSchema.mlkPaleTeal(),
                NSFontAttributeName : UIFont.systemFont(ofSize: 17)
            ]

            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        } else {
            // Fallback on earlier versions
        }

    }
    
    override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
        super.setShowsCancelButton(showsCancelButton, animated: animated)
        if showsCancelButton {
            for ob: UIView in ((self.subviews[0] )).subviews {
                if let z = ob as? UIButton {
                    let btn: UIButton = z
                    btn.setTitle("Huỷ".localized(), for: .normal)
                    btn.setTitleColor(ColorSchema.mlkWarmGrey(), for: .normal)
                }
            }
        }
    }
}
