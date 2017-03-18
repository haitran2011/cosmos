//
//  ListPlayListViewController.swift
//  cosmos
//
//  Created by HieuiOS on 2/8/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import PKHUD
import GoogleMobileAds

class ListPlayListViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: ListPlayListDelegate?
    var refreshControl: UIRefreshControl!
    var dataSource: ListPlayListDataSource!
    var pageToken: String?
    var viewType = ViewType.list
    var state = LoadingState.initial
    var allHasLoaded = false
    var totalCount = 0
    var interstitialChangeListClick: GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ListPlayListDataSource(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.emptyDataSetDelegate = dataSource
        collectionView.emptyDataSetDataSource = dataSource
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorSchema.appTheme()
        refreshControl.addTarget(self, action: #selector(reloadAllData(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        self.refreshData(.loading, pageToken: nil)
    }
    override func setupUI() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: IBAction handle
extension ListPlayListViewController{
    func changeList(_ sender: Any) -> Void {
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
        //add ads
        //loadInterstitialChangeViewStyle()
    }
    func filter(_ sender : Any) -> Void {
        
    }
    func reloadAllData(_ sender: Any){
        self.refreshData(.refresh, pageToken: nil)
    }
}
//MARK: Private method
extension ListPlayListViewController{
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
        APIClient.currentClient()?.getPlaylists(20, pageToken: pageToken, completionHandler: {[weak self] (response, error) in
            guard let strongSelf = self else{
                return
            }
            if fetchType == .refresh {
                strongSelf.refreshControl.endRefreshing()
            }else if fetchType == .loading{
                HUD.hide()
            }
            if error == nil{
                strongSelf.totalCount = (response?.totalResults)!
                strongSelf.pageToken = response?.nextPageToken
                if fetchType == .refresh {
                    
                    strongSelf.dataSource.data = (response?.items)!
                }else{
                    strongSelf.dataSource.data.append(contentsOf: (response?.items)!)
                }
                strongSelf.collectionView.reloadData()
            }else{
                strongSelf.handleError(error!)
            }
        })
    }
    func loadInterstitialChangeViewStyle(){
        if let _ = interstitialChangeListClick{
            interstitialChangeListClick = nil            
        }
        interstitialChangeListClick = GADInterstitial(adUnitID: "ca-app-pub-8322212054190086/5593522254")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        //request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9a" ]
        interstitialChangeListClick.load(request)
        interstitialChangeListClick.delegate = self
        
    }
}

extension ListPlayListViewController: GADInterstitialDelegate{
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if interstitialChangeListClick.isReady{
            interstitialChangeListClick.present(fromRootViewController: self)
        }
    }
}

//MARK: UICollectionViewDelegate
extension ListPlayListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard dataSource.data.count > 0 else {
            return
        }
        let playlistItem = dataSource.data[indexPath.row]
        if let delegate = self.delegate{
            delegate.didSelecPlayList(playlistItem.playlistID!)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > dataSource.data.count - 2 {
            self.refreshData(.loadmore, pageToken: pageToken)
        }
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension ListPlayListViewController: UICollectionViewDelegateFlowLayout{
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
//                heigh = 221
                //heigh = 221
            }else if UIDevice.current.isIphone(){
//                heigh = 181
                //heigh = 181
                width = collectionView.frame.width/2.0 - 12*3/2.0
            }
            var playlist: PlayListItem?
            if dataSource.data.count > 0{
              playlist  = dataSource.data[indexPath.row]
            }            
            heigh = AppHelpers.heightforPlayListCell(playlist, width: width)
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














