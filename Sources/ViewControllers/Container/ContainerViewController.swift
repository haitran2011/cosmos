//
//  ContainerViewController.swift
//  cosmos
//
//  Created by HieuiOS on 3/14/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ContainerViewController: ViewController {
    var pageMenu: CAPSPageMenu?
    var viewControllers: [UIViewController] = []
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
    }
    override func setupUI() {
        let logo = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: logo)
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon List view"), style: .plain, target: self, action: #selector(changeList(_ : )))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    override func loadBanner() {
        bannerView.adUnitID = "ca-app-pub-8322212054190086/8826190259"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let videoVC = segue.destination as! VideoListViewController
        let playListID = sender as! String
        videoVC.playlistID = playListID
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
}
//MARK: Private Method
extension ContainerViewController{
    func setupPage(){
        let storyBoard = UIStoryboard.storyboard(.main, bundle: nil)
        let playListVC: ListPlayListViewController  = storyBoard.instantiateViewController()
        playListVC.title = "Danh sách".localized()
        playListVC.delegate = self
        viewControllers.append(playListVC)
        let videoTabVC: VideoTabViewController  = storyBoard.instantiateViewController()
        videoTabVC.title = "Videos".localized()
        viewControllers.append(videoTabVC)

        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(.white),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .menuMargin(20.0),
            .menuHeight(40.0),
            .selectedMenuItemLabelColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: viewControllers, frame: CGRect(x: 0.0, y: 64, width: self.view.frame.width, height: self.view.frame.height - (self.tabBarController?.tabBar.height)! - bannerView.height), pageMenuOptions: parameters)
        
//        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        view.bringSubview(toFront: bannerView)
//        pageMenu!.didMove(toParentViewController: self)
    }
}
//MARK: IBAction
extension ContainerViewController{
    func changeList(_ sender: Any) -> Void {
//        let buttonBar = sender as! UIBarButtonItem
//        switch viewType {
//        case .list:
//            viewType = .grid
//            break
//        case .grid:
//            viewType = .list
//            break
//        }
//        setupRightBarbutton(with: viewType, buttonBar: buttonBar)
//        dataSource.viewType = viewType
//        collectionView.reloadData()
        //add ads
        //loadInterstitialChangeViewStyle()
    }
}

extension ContainerViewController: ListPlayListDelegate{
    func didSelecPlayList(_ playlistID: String) {
        self.performSegue(withIdentifier: "showListVideo", sender: playlistID)
    }
}
