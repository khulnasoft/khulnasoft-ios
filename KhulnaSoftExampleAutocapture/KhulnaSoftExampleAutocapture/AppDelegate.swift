/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The application-specific delegate class.
 */

import KhulnaSoft
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = KhulnaSoftConfig(
            apiKey: "phc_QFbR1y41s5sxnNTZoyKG2NJo2RlsCIWkUfdpawgb40D"
        )
        config.debug = true

        config.captureElementInteractions = true
        config.captureApplicationLifecycleEvents = true
        config.sendFeatureFlagEvent = false

        config.sessionReplay = true
        config.captureScreenViews = true
        config.sessionReplayConfig.screenshotMode = true
        config.sessionReplayConfig.maskAllTextInputs = false
        config.sessionReplayConfig.maskAllImages = false

        KhulnaSoftSDK.shared.setup(config)

        KhulnaSoftSDK.shared.identify("Max Capture")

        return true
    }
}
