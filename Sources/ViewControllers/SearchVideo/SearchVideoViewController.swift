//
//  SearchVideoViewController.swift
//  cosmos
//
//  Created by HieuiOS on 2/12/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import MobilePlayer
import GoogleMobileAds

class SearchVideoViewController: ViewController {
    @IBOutlet weak var searchView: BaseSearchView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var viewType = ViewType.list
    var dataSource: SearchVideoDataSource!
//    var refreshControl: UIRefreshControl!
    var pageToken: String?
    var pageDetailToken: String?
    var state = LoadingState.initial
    var allHasLoaded = false
    var totalCount = 0
    var searchRequest: Request?
    var videoRequest: Request?
    var query: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = SearchVideoDataSource(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.emptyDataSetDelegate = dataSource
        collectionView.emptyDataSetDataSource = dataSource
        collectionView.alwaysBounceVertical = true
        searchView.searchDelegate = self
    }
    override func setupUI() {
        let logo = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: logo)
//        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Group"), style: .plain, target: self, action: #selector(changeList(_ : )))
//        self.navigationItem.rightBarButtonItem = rightItem        
//        let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon filter") , style: .plain, target: self, action: #selector(filter(_ : )))
//        self.navigationItem.leftBarButtonItem = leftItem
        loadingView.isHidden = true
        loadingView.color = ColorSchema.appTheme()
    }
    
    override func loadBanner() {
        bannerView.adUnitID = "ca-app-pub-8322212054190086/2640055854"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SettingManager.currentSetting().enableRotateScreen{
            SettingManager.currentSetting().enableRotateScreen = false
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: IBAction Handle
extension SearchVideoViewController{
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
//    func reloadAllData(_ sender: Any){
//        self.refreshData(.refresh, pageToken: pageToken)
//    }
}
//MARK: Private method
extension SearchVideoViewController{
    func cancelSearchRequest(){
        searchRequest?.cancel()
        videoRequest?.cancel()
        dataSource.data.removeAll()
        collectionView.reloadData()
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
    func refreshData(_ fetchType: FetchType, pageToken: String? , text: String?){
        
        if fetchType == .refresh {
            totalCount = 0
//            refreshControl.beginRefreshing()
        }else if fetchType == .loading{
            if totalCount != 0,dataSource.data.count >= totalCount{
//                refreshControl.endRefreshing()
                return
            }
            //HUD.show(.progress)
            loadingView.startAnimating()
            loadingView.isHidden = false
        }else if fetchType == .loadmore{
            if totalCount != 0,dataSource.data.count >= totalCount{
                return
            }
        }
       searchRequest = APIClient.currentClient()?.search(10, pageToken: self.pageToken, order: OrderSearchType.date.rawValue, query: text, searchType: SearchType.video.rawValue, completionHandler: {[weak self] (response, error) in
            guard let strongSelf = self else{
                return
            }
            if error == nil{
                strongSelf.totalCount = (response?.totalResults)!
                strongSelf.pageToken = response?.nextPageToken
                
                let videos: [SearchVideoItem] = (response?.items)!
                let videoIDs = videos.flatMap({ $0.videoID })
                
              strongSelf.videoRequest =  APIClient.currentClient()?.getVideos(10, pageToken: strongSelf.pageDetailToken , videoIDs: videoIDs, completionHandler: { (responseDetail, error) in
                    if fetchType == .refresh {
                        //strongSelf.refreshControl.endRefreshing()
                    }else if fetchType == .loading{
                        //HUD.hide()
                        strongSelf.loadingView.startAnimating()
                        strongSelf.loadingView.isHidden = true
                    }
                    if error == nil{
                        if fetchType == .refresh {
                            
                            strongSelf.dataSource.data = (responseDetail?.items)!
                        }else{
                            strongSelf.dataSource.data.append(contentsOf: (responseDetail?.items)!)
                        }
                        strongSelf.collectionView.reloadData()
                    }else{
                        //strongSelf.handleError(error!)
                        strongSelf.loadingView.isHidden = true
                    }
                })
            }else{
                //strongSelf.handleError(error!)
                strongSelf.loadingView.isHidden = true
            }
            
        })
    }
}
//MARK: UICollectionViewDelegate
extension SearchVideoViewController: UICollectionViewDelegate{
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
            self.refreshData(.loadmore, pageToken: pageToken, text: query)
        }
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension SearchVideoViewController: UICollectionViewDelegateFlowLayout{
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
//MARK:
extension SearchVideoViewController: BaseSearchViewDelegate {
    func didStartSearching() {
        print("didStartSearching")
    }
    
    func didTapOnSearchButton() {
        print("didTapOnSearchButton")
    }
    
    func didTapOnCancelButton() {
        print("didTapOnCancelButton")
        cancelSearchRequest()
        dataSource.data.removeAll()
        collectionView.reloadData()
    }
    
    func didChangeSearchText(_ searchText: String) {
        print("didChangeSearchText")
        query = searchText
        cancelSearchRequest()
        if searchText.isEmpty{
            dataSource.data.removeAll()
            collectionView.reloadData()
            return
        }
        refreshData(.loading, pageToken: pageToken, text: searchText)
    }
}
