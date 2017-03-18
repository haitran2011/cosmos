//
//  VideoListViewController.swift
//  cosmos
//
//  Created by HieuiOS on 2/11/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import PKHUD
import MobilePlayer
import GoogleMobileAds

class VideoListViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewType = ViewType.list
    var dataSource: VideoDataSource!
    var refreshControl: UIRefreshControl!
    var pageToken: String?
    var pageDetailToken: String?
    var state = LoadingState.initial
    var allHasLoaded = false
    var totalCount = 0
    var playlistID = ""
    var interstitialItemClick: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = VideoDataSource(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.emptyDataSetDelegate = dataSource
        collectionView.emptyDataSetDataSource = dataSource
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorSchema.appTheme()
        refreshControl.addTarget(self, action: #selector(reloadAllData(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        self.refreshData(.loading, pageToken: pageToken)
        loadInterstitialItemClick()
    }
    override func setupUI() {
        let logo = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: logo)
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Group"), style: .plain, target: self, action: #selector(changeList(_ : )))
        //rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
//        let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon filter") , style: .plain, target: self, action: #selector(filter(_ : )))
//        //leftItem.tintColor = .white
//        self.navigationItem.leftBarButtonItem = leftItem
        let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(doBack(_:)))
//        leftItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SettingManager.currentSetting().enableRotateScreen{
            SettingManager.currentSetting().enableRotateScreen = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK: IBAction Handle
extension VideoListViewController{
    func changeList(_ sender: Any ){
        let buttonBar = sender as! UIBarButtonItem
        switch viewType {
        case .list:
            viewType = .grid
            break
        case .grid:
            viewType = .list
            break
        }
        setupRightBarbutton(with: viewType, buttonBar: buttonBar)
        dataSource.viewType = viewType
        collectionView.reloadData()
    }
    func filter(_ sender: Any ) {
        
    }
    func doBack(_ sender: Any){
        doClose()
    }
    func reloadAllData(_ sender: Any){
        self.refreshData(.refresh, pageToken: pageToken)
    }
}
//MARK: Private method
extension VideoListViewController{
    func refreshData(_ fetchType: FetchType, pageToken: String?){
        
        if fetchType == .refresh {
            totalCount = 0
            refreshControl.beginRefreshing()
        }else if fetchType == .loading{
            if totalCount != 0,dataSource.data.count >= totalCount{
                refreshControl.endRefreshing()
                return
            }
            HUD.show(.progress)
        }else if fetchType == .loadmore{
            if totalCount != 0,dataSource.data.count >= totalCount{
                return
            }
        }
        APIClient.currentClient()?.getPlaylistItems(20, pageToken: pageToken, playlistId: playlistID, completionHandler: {[weak self] (response, error) in
            guard let strongSelf = self else{
                return
            }
            if error == nil{
                strongSelf.totalCount = (response?.totalResults)!
                strongSelf.pageToken = response?.nextPageToken

                let videos: [VideoItem] = (response?.items)!
                let videoIDs = videos.flatMap({ $0.videoID })
                
                APIClient.currentClient()?.getVideos(20, pageToken: strongSelf.pageDetailToken , videoIDs: videoIDs, completionHandler: { (responseDetail, error) in
                    if fetchType == .refresh {
                        strongSelf.refreshControl.endRefreshing()
                    }else if fetchType == .loading{
                        HUD.hide()
                    }
                    if error == nil{
                        if fetchType == .refresh {
                            
                            strongSelf.dataSource.data = (responseDetail?.items)!
                        }else{
                            strongSelf.dataSource.data.append(contentsOf: (responseDetail?.items)!)
                        }
                        strongSelf.collectionView.reloadData()
                    }else{
                        strongSelf.handleError(error!)
                    }
                })
            }else{
                strongSelf.handleError(error!)
            }

        })
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
        presentMoviePlayerViewControllerAnimated(playerVC)
    }
    func loadInterstitialItemClick(){
        interstitialItemClick = GADInterstitial(adUnitID: "ca-app-pub-8322212054190086/4116789053")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9a" ]
        interstitialItemClick.load(request)
        interstitialItemClick.delegate = self
    }
}
//MARK: GADInterstitialDelegate
extension VideoListViewController: GADInterstitialDelegate{
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if interstitialItemClick.isReady{
            interstitialItemClick.present(fromRootViewController: self)
        }
    }
}


//MARK: UICollectionViewDelegate
extension VideoListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.dataSource.data.count > 0 else {
            return
        }
        SettingManager.currentSetting().enableRotateScreen = true
        let videoItem = dataSource.data[indexPath.row]
        DataStore.sharedInstance.addVideoItem(videoItem)
        let videoID = videoItem.videoID
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID!)")!
        self.playVideo(youtubeURL)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > dataSource.data.count - 2 {
            self.refreshData(.loadmore, pageToken: pageToken)
        }
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension VideoListViewController: UICollectionViewDelegateFlowLayout{
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
//                    heigh = 221
                }else if UIDevice.current.isIphone(){
//                    heigh = 181
//                     heigh = 191
                    width = collectionView.frame.width/2.0 - 12*3/2.0
                }
                var videoItem: VideoDetailItem?
                if dataSource.data.count > 0{
                    videoItem  = dataSource.data[indexPath.row]
                }
                heigh = AppHelpers.heightForCell(videoItem, width: width)
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
