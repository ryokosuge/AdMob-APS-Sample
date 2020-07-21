//
//  ViewController.swift
//  AdMob-APS-Sample
//
//  Created by ryokosuge on 2020/07/21.
//  Copyright © 2020 ryokosuge. All rights reserved.
//

import UIKit
import GoogleMobileAds
import DTBiOSSDK

class ViewController: UIViewController {

    // AdMobのバナー（320x50）のAdUnitIDを入れてください
    let adMobAdUnitID = "ca-app-pub-2222899768110117/5645225761"
    // APSのSlotUUIDを入れてください
    // testid
    let apsSlotUUID = "e0c7923c-4885-4c8d-87dd-57bb637365f7"
    
    private var bannerView: GADBannerView?
    private var adLoader: DTBAdLoader = DTBAdLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // AdLoader
        guard let size = DTBAdSize(bannerAdSizeWithWidth: 320, height: 50, andSlotUUID: apsSlotUUID) else {
            return
        }
        adLoader.setAdSizes([size])
        adLoader.loadAd(self)
    }

}

// MARK: - GADAdCallback

extension ViewController: DTBAdCallback {
    
    func onFailure(_ error: DTBAdError) {
        print(#function, "error:    \(error)")
        loadBannerView(with: nil)
    }

    func onSuccess(_ adResponse: DTBAdResponse!) {
        loadBannerView(with: adResponse)
    }
    
}

// MARK: - load banner view

extension ViewController {

    private func loadBannerView(with response: DTBAdResponse?) {
        clearBannerView()
        
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.adUnitID = adMobAdUnitID
        bannerView.rootViewController = self
        bannerView.delegate = self

        view.addSubview(bannerView)
        // auto layout
        // sizeは320x50
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 50),
            bannerView.widthAnchor.constraint(equalToConstant: 320)
        ])

        self.bannerView = bannerView
        let request = GADRequest()
        
        if let response = response {
            let amznSlots = response.amznSlots()
            let mediationHints = response.mediationHints()
            print("amznSlots:   \(amznSlots) / mediationHints:  \(mediationHints)")
            let extra = GADCustomEventExtras()
            extra.setExtras(mediationHints, forLabel: amznSlots)
            request.register(extra)
        }

        bannerView.load(request)
    }

    private func clearBannerView() {
        bannerView?.removeFromSuperview()
        bannerView?.delegate = nil
        bannerView = nil
    }

}

// MARK: - GADBannerViewDelegate

extension ViewController: GADBannerViewDelegate {

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print(#function, bannerView, "adNetworkClassName: \(bannerView.responseInfo?.adNetworkClassName ?? "nil")")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(#function, bannerView, "error:    \(error.localizedDescription)")
    }

}
