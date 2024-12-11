//
//  AppDelegate.swift
//  KhulnaSoftExampleWithPods
//
//  Created by Manoel Aranda Neto on 24.10.23.
//

import Foundation
import KhulnaSoft
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let defaultCenter = NotificationCenter.default

        defaultCenter.addObserver(self,
                                  selector: #selector(receiveFeatureFlags),
                                  name: KhulnaSoftSDK.didReceiveFeatureFlags,
                                  object: nil)

        let config = KhulnaSoftConfig(
            apiKey: "phc_QFbR1y41s5sxnNTZoyKG2NJo2RlsCIWkUfdpawgb40D"
        )

        KhulnaSoftSDK.shared.setup(config)
        KhulnaSoftSDK.shared.debug()
        KhulnaSoftSDK.shared.capture("Event from CocoaPods example!")

        return true
    }

    @objc func receiveFeatureFlags() {
        print("receiveFeatureFlags")
    }
}
