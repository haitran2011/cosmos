//
//  VideoDataSource.swift
//  cosmos
//
//  Created by HieuiOS on 2/23/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import Alamofire

class VideoDataSource: NSObject {
    fileprivate unowned var collectionView: UICollectionView
    var data = [VideoDetailItem] ()
    var viewType = ViewType.list
    var loadedAll:Bool = false
    var currentPage: Int = 0
    var state = LoadingState.initial
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
}
extension VideoDataSource: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard data.count > 0 else {
            return UICollectionViewCell()
        }
        switch viewType {
        case .list:
            let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoListCell.reuseIdentifier, for: indexPath) as! VideoListCell
            listCell.setupCell(with: data[indexPath.row])
            return listCell
        case .grid:
            let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoGridCell.reuseIdentifier, for: indexPath) as! VideoGridCell
            gridCell.setupCell(with: data[indexPath.row])
            return gridCell
        }
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        if kind == UICollectionElementKindSectionFooter {
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewFooter.reuseIdentifier, for: indexPath) as! CollectionViewFooter
//            footer.setup(for: state)
//            
//            return footer
//        }else{
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:"header", for: indexPath)
//            return header
//        }
//    }
}
//MARK: TBEmptyDataSetDelegate
extension VideoDataSource: TBEmptyDataSetDelegate{
    func emptyDataSetShouldDisplay(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyDataSetTapEnabled(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyDataSetScrollEnabled(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyDataSetDidTapEmptyView(in scrollView: UIScrollView) {
        //        let alert = UIAlertController(title: nil, message: "Did Tap EmptyDataView!", preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //        alert.addAction(cancelAction)
        //        present(alert, animated: true, completion: nil)
    }
    
    func emptyDataSetWillAppear(in scrollView: UIScrollView) {
        print("EmptyDataSet Will Appear!")
    }
    
    func emptyDataSetDidAppear(in scrollView: UIScrollView) {
        print("EmptyDataSet Did Appear!")
    }
    
    func emptyDataSetWillDisappear(in scrollView: UIScrollView) {
        print("EmptyDataSet Will Disappear!")
    }
    
    func emptyDataSetDidDisappear(in scrollView: UIScrollView) {
        print("EmptyDataSet Did Disappear!")
    }
}
//MARK: TBEmptyDataSetDataSource
extension VideoDataSource: TBEmptyDataSetDataSource{
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return nil//EmptyData.images[indexPath.row]
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        let title = "No playlist found".localized()//EmptyData.titles[indexPath.row]
        var attributes: [String: Any]?
        attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17), NSForegroundColorAttributeName: ColorSchema.appTheme()]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        //        let description = EmptyData.descriptions[indexPath.row]
        //        var attributes: [String: Any]?
        //        if indexPath.row == 1 {
        //            attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17.0), NSForegroundColorAttributeName: UIColor(red: 3 / 255, green: 169 / 255, blue: 244 / 255, alpha: 1)]
        //        } else if indexPath.row == 2 {
        //            attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0), NSForegroundColorAttributeName: UIColor.purple]
        //        }
        //        return NSAttributedString(string: description, attributes: attributes)
        return nil
    }
    
    func verticalOffsetForEmptyDataSet(in scrollView: UIScrollView) -> CGFloat {
        //        if let navigationBar = navigationController?.navigationBar {
        //            return -navigationBar.frame.height * 0.75
        //        }
        return -60
    }
    
    //    func verticalSpacesForEmptyDataSet(in scrollView: UIScrollView) -> [CGFloat] {
    //        return [25, 8]
    //    }
    
    func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        //        if isLoading {
        //            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //            activityIndicator.startAnimating()
        //            return activityIndicator
        //        }
        return nil
    }
}
