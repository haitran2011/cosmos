//
//  HistoryViewController.swift
//  cosmos
//
//  Created by HieuiOS on 2/12/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import MobilePlayer
import GoogleMobileAds

class HistoryViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var viewType = ViewType.list
    var dataSource: HistoryDataSource!
    //    var refreshControl: UIRefreshControl!
    var pageToken: String?
    var pageDetailToken: String?
    var state = LoadingState.initial
    var allHasLoaded = false
    var totalCount = 0
    var playlistID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = HistoryDataSource(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.emptyDataSetDelegate = dataSource
        collectionView.emptyDataSetDataSource = dataSource
        collectionView.alwaysBounceVertical = true
        // Do any additional setup after loading the view.
    }
    override func setupUI() {
        let logo = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: logo)
//        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Group"), style: .plain, target: self, action: #selector(changeList(_ : )))
//        self.navigationItem.rightBarButtonItem = rightItem
//        let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon filter") , style: .plain, target: self, action: #selector(filter(_ : )))
//        self.navigationItem.leftBarButtonItem = leftItem
    }
    override func loadBanner() {
        bannerView.adUnitID = "ca-app-pub-8322212054190086/7209856255"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SettingManager.currentSetting().enableRotateScreen{
            SettingManager.currentSetting().enableRotateScreen = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.data = DataStore.sharedInstance.fetchAllVideoItemToDisplay()
        collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: UICollectionViewDelegate
extension HistoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.dataSource.data.count > 0 else {
            return
        }
        SettingManager.currentSetting().enableRotateScreen = true
        let videoItem = dataSource.data[indexPath.row]
        let videoID = videoItem.videoID
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID!)")!
        self.playVideo(youtubeURL)
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension HistoryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = 0
        var heigh:CGFloat = 0
        if dataSource.viewType == .list{
            
            if UIDevice.current.isIpad(){
                heigh = 150
                width = collectionView.frame.width - 14*2
            }else if UIDevice.current.isIphone(){
                heigh = 94
                width = collectionView.frame.width - 12*2
            }
        }else{
            if UIDevice.current.isIpad(){
                width = collectionView.frame.width/3.0 - 14*4/3.0
                heigh = 221
            }else if UIDevice.current.isIphone(){
                heigh = 181
                width = collectionView.frame.width/2.0 - 12*3/2.0
            }
        }
        return CGSize(width: width, height: heigh)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edge = UIEdgeInsets.zero
        if dataSource.viewType == .list{
            if UIDevice.current.isIpad(){
                edge = UIEdgeInsetsMake(0, 14, 0, 14)
            }else if UIDevice.current.isIphone(){
                edge = UIEdgeInsetsMake(0, 12, 0, 12)
            }
        }else{
            if UIDevice.current.isIphone() {
                edge = UIEdgeInsetsMake(12, 12, 12, 12)
            }else if UIDevice.current.isIpad(){
                edge = UIEdgeInsetsMake(14, 14, 14, 14)
            }
        }
        return edge
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var spacing:CGFloat = 0
        if dataSource.viewType == .list{
            spacing = 0
        }else{
            if UIDevice.current.isIpad() {
                spacing = 14
            }else if UIDevice.current.isIphone(){
                spacing = 12
            }
        }
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        var spacing:CGFloat = 0
        if dataSource.viewType == .list{
            spacing = 0
        }else{
            if UIDevice.current.isIpad() {
                spacing = 14
            }else if UIDevice.current.isIphone(){
                spacing = 12
            }
        }
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenWidth = collectionView.frame.width
        return CGSize(width: screenWidth - 10, height: 0)
        
    }
}

//MARK: IBAction Handle
extension HistoryViewController{
    func changeList(_ sender: Any ){
        
    }
    func filter(_ sender: Any ) {
        
    }
    func playVideo(_ youtubeURl: URL ) {
        let bundle = Bundle.main
        let config = MobilePlayerConfig(fileURL: bundle.url(
            forResource: "MovielalaPlayer",
            withExtension: "json")!)
        let playerVC = MobilePlayerViewController(
            contentURL: youtubeURl,
            config: config)
        playerVC.activityItems = [youtubeURl]
        playerVC.showOverlayViewController(OverLayViewController())
        presentMoviePlayerViewControllerAnimated(playerVC)
    }
}
