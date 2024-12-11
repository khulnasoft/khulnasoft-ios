//
//  AutocaptureEventProcessing.swift
//  KhulnaSoft
//
//  Created by Yiannis Josephides on 30/10/2024.
//

#if os(iOS) || targetEnvironment(macCatalyst)
    import Foundation

    protocol AutocaptureEventProcessing: AnyObject {
        func process(source: KhulnaSoftAutocaptureEventTracker.EventSource, event: KhulnaSoftAutocaptureEventTracker.EventData)
    }
#endif
