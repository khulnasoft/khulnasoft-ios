import Cocoa
import KhulnaSoft

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        let config = KhulnaSoftConfig(
            apiKey: "phc_QFbR1y41s5sxnNTZoyKG2NJo2RlsCIWkUfdpawgb40D"
        )
        config.debug = true

        KhulnaSoftSDK.shared.setup(config)
//        KhulnaSoftSDK.shared.capture("Event from MacOS example!")
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
}
