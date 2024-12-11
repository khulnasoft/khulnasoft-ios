# How to use the iOS SDK v3

## Setup

### CocoaPods

```text
pod "KhulnaSoft", "~> 3.0.0"
```

### SPM

```swift
dependencies: [
  .package(url: "https://github.com/KhulnaSoft/khulnasoft-ios.git", from: "3.0.0")
],
```

## Examples

```swift
import KhulnaSoft

let config = KhulnaSoftConfig(apiKey: apiKey)
KhulnaSoftSDK.shared.setup(config)
```

Set a custom `host` (Self-Hosted)

```swift
let config = KhulnaSoftConfig(apiKey: apiKey, host: host)
```

Change the default configuration

```swift
let config = KhulnaSoftConfig(apiKey: apiKey)
config.captureScreenViews = false
config.captureApplicationLifecycleEvents = false
config.debug = true
// .. and more
```

If you don't want to use the global/singleton instance, you can create your own KhulnaSoft SDK instance
and hold it

```swift
let config = KhulnaSoftConfig(apiKey: apiKey)
let khulnaSoft = KhulnaSoftSDK.with(config)

KhulnaSoftSDK.shared.capture("user_signed_up")
```

Enable or Disable the SDK to capture events

```swift
// During SDK setup
let config = KhulnaSoftConfig(apiKey: apiKey)
// the SDK is enabled by default
config.optOut = true
KhulnaSoftSDK.shared.setup(config)

// At runtime
KhulnaSoftSDK.shared.optOut()

// Check it and opt-in
if (KhulnaSoftSDK.shared.isOptOut()) {
    KhulnaSoftSDK.shared.optIn()
}
```

Capture a screen view event

```swift
let config = KhulnaSoftConfig(apiKey: apiKey)
// it's enabled by default
config.captureScreenViews = true
KhulnaSoftSDK.shared.setup(config)

// Or manually
KhulnaSoftSDK.shared.screen("Dashboard", properties: ["url": "...", "background": "blue"])
```

Capture an event

```swift
KhulnaSoftSDK.shared.capture("Dashboard", properties: ["is_free_trial": true])
// check out the `userProperties`, `userPropertiesSetOnce` and `groupProperties` parameters.
```

Identify the user

```swift
KhulnaSoftSDK.shared.identify("user123", userProperties: ["email": "user@KhulnaSoftSDK.shared.com"])
```

Create an alias for the current user

```swift
KhulnaSoftSDK.shared.alias("theAlias")
```

Identify a group

```swift
KhulnaSoftSDK.shared.group(type: "company", key: "company_id_in_your_db", groupProperties: ["name": "Awesome Inc."])
```

Registering and unregistering a context to be sent for all the following events

```swift
// Register
KhulnaSoftSDK.shared.register(["team_id": 22])

// Unregister
KhulnaSoftSDK.shared.unregister("team_id")
```

Load feature flags automatically

```swift
// Subscribe to feature flags notification
NotificationCenter.default.addObserver(self, selector: #selector(receiveFeatureFlags), name: KhulnaSoftSDK.didReceiveFeatureFlags, object: nil)
KhulnaSoftSDK.shared.setup(config)

The "receiveFeatureFlags" method will be called when the SDK receives the feature flags from the server.

// And/Or manually
KhulnaSoftSDK.shared.reloadFeatureFlags {
    if KhulnaSoftSDK.shared.isFeatureEnabled("paidUser") {
        // do something
    }
}
```

Read feature flags

```swift
let paidUser = KhulnaSoftSDK.shared.isFeatureEnabled("paidUser")

// Or
let paidUser = KhulnaSoftSDK.shared.getFeatureFlag("paidUser") as? Bool
```

Read feature flags variant/payload

```swift
let premium = KhulnaSoftSDK.shared.getFeatureFlagPayload("premium") as? Bool
```

Read the current `distinctId`

```swift
let distinctId = KhulnaSoftSDK.shared.getDistinctId()
```

Flush the SDK by sending all the pending events right away

```swift
KhulnaSoftSDK.shared.flush()
```

Reset the SDK and delete all the cached properties

```swift
KhulnaSoftSDK.shared.reset()
```

Close the SDK

```swift
KhulnaSoftSDK.shared.close()
```

## Breaking changes

- `receivedRemoteNotification` has been removed.
- `registeredForRemoteNotificationsWithDeviceToken` has been removed.
- `handleActionWithIdentifier` has been removed.
- `continueUserActivity` has been removed.
- `openURL` has been removed.
- `captureDeepLinks` has been removed.
- `captureInAppPurchases` has been removed.
- `capturePushNotifications` has been removed.
- `shouldUseLocationServices` config has been removed.
- `payloadFilters` config has been removed.
- `shouldUseBluetooth` config has been removed.
- `crypto` config has been removed.
- `middlewares` config has been removed.
- `httpSessionDelegate` config has been removed.
- `requestFactory` config has been removed.
- `shouldSendDeviceID` config has been removed, events won't contain the `$device_id` attribute anymore.
- `launchOptions` config has been removed, the `Application Opened` event won't contain the `referring_application` and `url` attributes anymore.
- `captureScreenViews` is enabled by default (it does not work on SwiftUI)
- `captureApplicationLifecycleEvents` is enabled by default

For the removed methods, you can use the `KhulnaSoftSDK.shared.capture` methods manually instead.

If any of the breaking changes are blocking you, please [open an issue](https://github.com/KhulnaSoft/khulnasoft-ios/issues/new) and let us know your use case.

## iOS Session Recording

Enable `Record user sessions` on the [KhulnaSoft project settings](https://us.khulnasoft.com/settings/project-replay#replay).

Requires the iOS SDK version >= [3.6.1](https://github.com/KhulnaSoft/khulnasoft-ios/releases/).

Enable the SDK to capture Session Recording.

```swift
let config = KhulnaSoftConfig(apiKey: apiKey)
// sessionReplay is disabled by default
config.sessionReplay = true
// sessionReplayConfig is optional, they are enabled by default
config.sessionReplayConfig.maskAllTextInputs = true
config.sessionReplayConfig.maskAllImages = true
config.sessionReplayConfig.captureNetworkTelemetry = true
// screenshotMode is disabled by default
// The screenshot may contain sensitive information, use with caution
config.sessionReplayConfig.screenshotMode = true
```

If you don't want to mask everything, you can disable the mask config above and mask specific views using the `ph-no-capture` [accessibilityIdentifier](https://developer.apple.com/documentation/uikit/uiaccessibilityidentification/1623132-accessibilityidentifier) or [accessibilityLabel](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel).

### Limitations

- [SwiftUI](https://developer.apple.com/xcode/swiftui/) is only supported if the `screenshotMode` option is enabled.
- It's a representation of the user's screen, not a video recording nor a screenshot.
  - Custom views are not fully supported.
  - If the option `screenshotMode` is enabled, the SDK will take a screenshot of the screen instead of making a representation of the user's screen.
- WebView is not supported, a placeholder will be shown.
- React Native and Flutter for iOS aren't supported.
