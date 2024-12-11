//
//  KhulnaSoftExampleApp.swift
//  KhulnaSoftExample
//
//  Created by Ben White on 10.01.23.
//

import SwiftUI

@main
struct KhulnaSoftExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .khulnaSoftScreenView() // will infer the class name (ContentView)
        }
    }
}
