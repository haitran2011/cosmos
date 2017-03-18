//
//  AboutViewController.swift
//  cosmos
//
//  Created by HieuiOS on 2/12/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import GoogleMobileAds
import ActiveLabel
import SafariServices

class AboutViewController: ViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var labelContent: ActiveLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelContent.handleURLTap {[weak self] (url) in
            guard let strongSelf = self else{
                return
            }
            if #available(iOS 9.0, *) {
                let safaricontroller = SFSafariViewController(url: url)
                strongSelf.present(safaricontroller, animated: true, completion: { 
                    
                })
            } else {
                // Fallback on earlier versions
            }
        }
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
