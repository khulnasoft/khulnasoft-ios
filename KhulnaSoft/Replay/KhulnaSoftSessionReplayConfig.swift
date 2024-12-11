//
//  KhulnaSoftSessionReplayConfig.swift
//  KhulnaSoft
//
//  Created by Manoel Aranda Neto on 19.03.24.
//
#if os(iOS)
    import Foundation

    @objc(KhulnaSoftSessionReplayConfig) public class KhulnaSoftSessionReplayConfig: NSObject {
        /// Enable masking of all text and text input fields
        /// Experimental support
        /// Default: true
        @objc public var maskAllTextInputs: Bool = true

        /// Enable masking of all images to a placeholder
        /// Experimental support
        /// Default: true
        @objc public var maskAllImages: Bool = true

        /// Enable masking of all sandboxed system views
        /// These may include UIImagePickerController, PHPickerViewController and CNContactPickerViewController
        /// Experimental support
        /// Default: true
        @objc public var maskAllSandboxedViews: Bool = true

        /// Enable masking of images that likely originated from user's photo library
        /// Experimental support (UIKit only)
        /// Default: false
        ///
        /// - Note: Deprecated
        @available(*, deprecated, message: "This property has no effect and will be removed in the next major release. To learn how to manually mask user photos please see our Privacy controls documentation: https://khulnasoft.com/docs/session-replay/privacy?tab=iOS")
        @objc public var maskPhotoLibraryImages: Bool = false

        /// Enable capturing network telemetry
        /// Experimental support
        /// Default: true
        @objc public var captureNetworkTelemetry: Bool = true

        /// By default Session replay will capture all the views on the screen as a wireframe,
        /// By enabling this option, KhulnaSoft will capture the screenshot of the screen.
        /// The screenshot may contain sensitive information, use with caution.
        /// Experimental support
        /// Default: false
        @objc public var screenshotMode: Bool = false

        /// Deboucer delay used to reduce the number of snapshots captured and reduce performance impact
        /// This is used for capturing the view as a wireframe or screenshot
        /// The lower the number more snapshots will be captured but higher the performance impact
        /// Defaults to 1s
        @objc public var debouncerDelay: TimeInterval = 1.0

        // TODO: sessionRecording config such as networkPayloadCapture, captureConsoleLogs, sampleRate, etc
    }
#endif