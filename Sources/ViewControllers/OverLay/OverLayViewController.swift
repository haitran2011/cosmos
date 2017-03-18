//
//  OverLayViewController.swift
//  cosmos
//
//  Created by HieuiOS on 3/6/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import MobilePlayer
import GoogleMobileAds

class OverLayViewController: MobilePlayerOverlayViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadBanner() {
        bannerView.adUnitID = "ca-app-pub-8322212054190086/5733123051"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
}
