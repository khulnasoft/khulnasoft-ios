//
//  KhulnaSoftExampleMacOSApp.swift
//  KhulnaSoftExampleMacOS
//
//  Created by Manoel Aranda Neto on 10.11.23.
//

import SwiftUI

@main
struct KhulnaSoftExampleMacOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
