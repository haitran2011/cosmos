//
//  ParentInivteBaseSearchView.swift
//  MilkyChat
//
//  Created by tienle on 1/26/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

protocol BaseSearchViewDelegate: class {
    func didStartSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(_ searchText: String)
}

class BaseSearchView: MlkSearchBar {
    
    var searchDelegate : BaseSearchViewDelegate?
    override func setupUI() {
        super.setupUI()
        self.delegate = self
    }
}

extension BaseSearchView : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let anDelegate = searchDelegate {
            anDelegate.didStartSearching()
            self.setShowsCancelButton(true, animated: true)
            
            for ob: UIView in ((self.subviews[0] )).subviews {
                if let z = ob as? UIButton {
                    let btn: UIButton = z
                    btn.setTitleColor(ColorSchema.mlkWarmGrey(), for: .normal)
                }
            }
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        if let anDelegate = searchDelegate {
            anDelegate.didTapOnSearchButton()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        if let anDelegate = searchDelegate {
            anDelegate.didTapOnCancelButton()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let anDelegate = searchDelegate {
            anDelegate.didChangeSearchText(searchText)
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
}
