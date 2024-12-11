//
//  KhulnaSoftSwiftUIViewModifiers.swift
//  KhulnaSoft
//
//  Created by Manoel Aranda Neto on 05.09.24.
//

#if canImport(SwiftUI)
    import Foundation
    import SwiftUI

    struct KhulnaSoftSwiftUIViewModifier: ViewModifier {
        let viewEventName: String

        let screenEvent: Bool

        let properties: [String: Any]?

        func body(content: Content) -> some View {
            content.onAppear {
                if screenEvent {
                    KhulnaSoftSDK.shared.screen(viewEventName, properties: properties)
                } else {
                    KhulnaSoftSDK.shared.capture(viewEventName, properties: properties)
                }
            }
        }
    }

    public extension View {
        func khulnaSoftScreenView(_ screenName: String? = nil,
                               _ properties: [String: Any]? = nil) -> some View
        {
            let viewEventName = screenName ?? "\(type(of: self))"
            return modifier(KhulnaSoftSwiftUIViewModifier(viewEventName: viewEventName,
                                                       screenEvent: true,
                                                       properties: properties))
        }

        func khulnaSoftViewSeen(_ event: String,
                             _ properties: [String: Any]? = nil) -> some View
        {
            modifier(KhulnaSoftSwiftUIViewModifier(viewEventName: event,
                                                screenEvent: false,
                                                properties: properties))
        }
    }

#endif
