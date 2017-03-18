//
//  AboutViewController.swift
//  cosmos
//
//  Created by HieuiOS on 2/12/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AboutViewController: ViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupUI() {
        let logo = #imageLiteral(resourceName: "Logo")
        navigationItem.titleView = UIImageView(image: logo)
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Group"), style: .plain, target: self, action: #selector(changeList(_ : )))
        //rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
        let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon filter") , style: .plain, target: self, action: #selector(filter(_ : )))
        //leftItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftItem
    }
    override func loadBanner() {
        bannerView.adUnitID = "ca-app-pub-8322212054190086/1163322651"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: IBAction Handle
extension AboutViewController{
    func changeList(_ sender: Any ){
        
    }
    func filter(_ sender: Any ) {
        
    }
}
