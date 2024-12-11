//
//  KhulnaSoftExampleWatchOSApp.swift
//  KhulnaSoftExampleWatchOS Watch App
//
//  Created by Manoel Aranda Neto on 02.11.23.
//

import KhulnaSoft
import SwiftUI

@main
struct KhulnaSoftExampleWatchOSApp: App {
    init() {
        // TODO: init on app delegate instead
        let config = KhulnaSoftConfig(
            apiKey: "phc_QFbR1y41s5sxnNTZoyKG2NJo2RlsCIWkUfdpawgb40D"
        )

        KhulnaSoftSDK.shared.setup(config)
        KhulnaSoftSDK.shared.debug()
        KhulnaSoftSDK.shared.capture("Event from WatchOS example!")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
