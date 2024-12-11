//
//  KhulnaSoftConfig.swift
//  KhulnaSoft
//
//  Created by Ben White on 07.02.23.
//
import Foundation

@objc(KhulnaSoftConfig) public class KhulnaSoftConfig: NSObject {
    @objc(KhulnaSoftDataMode) public enum KhulnaSoftDataMode: Int {
        case wifi
        case cellular
        case any
    }

    @objc public let host: URL
    @objc public let apiKey: String
    @objc public var flushAt: Int = 20
    @objc public var maxQueueSize: Int = 1000
    @objc public var maxBatchSize: Int = 50
    @objc public var flushIntervalSeconds: TimeInterval = 30
    @objc public var dataMode: KhulnaSoftDataMode = .any
    @objc public var sendFeatureFlagEvent: Bool = true
    @objc public var preloadFeatureFlags: Bool = true
    @objc public var captureApplicationLifecycleEvents: Bool = true
    @objc public var captureScreenViews: Bool = true
    #if os(iOS) || targetEnvironment(macCatalyst)
        /// Enable autocapture for iOS
        /// Experimental support
        /// Default: false
        @objc public var captureElementInteractions: Bool = false
    #endif
    @objc public var debug: Bool = false
    @objc public var optOut: Bool = false
    @objc public var getAnonymousId: ((UUID) -> UUID) = { uuid in uuid }
    /// Hook that allows to sanitize the event properties
    /// The hook is called before the event is cached or sent over the wire
    @objc public var propertiesSanitizer: KhulnaSoftPropertiesSanitizer?
    /// Determines the behavior for processing user profiles.
    @objc public var personProfiles: KhulnaSoftPersonProfiles = .identifiedOnly

    /// The identifier of the App Group that should be used to store shared analytics data.
    /// KhulnaSoft will try to get the physical location of the App Group’s shared container, otherwise fallback to the default location
    /// Default: nil
    @objc public var appGroupIdentifier: String?

    /// Internal
    /// Do not modify it, this flag is read and updated by the SDK via feature flags
    @objc public var snapshotEndpoint: String = "/s/"

    /// or EU Host: 'https://eu.i.khulnasoft.com'
    public static let defaultHost: String = "https://us.i.khulnasoft.com"

    #if os(iOS)
        /// Enable Recording of Session Replays for iOS
        /// Experimental support
        /// Default: false
        @objc public var sessionReplay: Bool = false
        /// Session Replay configuration
        /// Experimental support
        @objc public let sessionReplayConfig: KhulnaSoftSessionReplayConfig = .init()
    #endif

    // only internal
    var disableReachabilityForTesting: Bool = false
    var disableQueueTimerForTesting: Bool = false
    // internal
    public var storageManager: KhulnaSoftStorageManager?

    @objc(apiKey:)
    public init(
        apiKey: String
    ) {
        self.apiKey = apiKey
        host = URL(string: KhulnaSoftConfig.defaultHost)!
    }

    @objc(apiKey:host:)
    public init(
        apiKey: String,
        host: String = defaultHost
    ) {
        self.apiKey = apiKey
        self.host = URL(string: host) ?? URL(string: KhulnaSoftConfig.defaultHost)!
    }
}