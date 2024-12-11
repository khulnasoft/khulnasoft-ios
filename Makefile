.PHONY: build buildSdk buildExamples format swiftLint swiftFormat test testOniOSSimulator testOnMacSimulator lint bootstrap releaseCocoaPods api

build: buildSdk buildExamples

buildSdk:
	set -o pipefail && xcrun xcodebuild -downloadAllPlatforms
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoft -destination generic/platform=ios | xcpretty #ios
	set -o pipefail && xcrun swift build --arch arm64 #macOS
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoft -destination generic/platform=macos | xcpretty #macOS
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoft -destination generic/platform=tvos | xcpretty #tvOS
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoft -destination generic/platform=watchos | xcpretty #watchOS
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoft -destination 'platform=visionOS Simulator,name=Apple Vision Pro' | xcpretty #visionOS

buildExamples:
	set -o pipefail && xcrun xcodebuild -downloadAllPlatforms
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoftExample -destination generic/platform=ios | xcpretty #ios
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoftExample -destination 'platform=visionOS Simulator,name=Apple Vision Pro' | xcpretty #visionOS
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoftObjCExample -destination generic/platform=ios | xcpretty #ObjC
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoftExampleMacOS -destination generic/platform=macos | xcpretty #macOS
	set -o pipefail && xcrun xcodebuild build -scheme 'KhulnaSoftExampleWatchOS Watch App' -destination generic/platform=watchos | xcpretty #watchOS
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoftExampleTvOS -destination generic/platform=tvos | xcpretty #watchOS
	cd KhulnaSoftExampleWithPods && pod install
	cd ..
	set -o pipefail && xcrun xcodebuild build -workspace KhulnaSoftExampleWithPods/KhulnaSoftExampleWithPods.xcworkspace -scheme KhulnaSoftExampleWithPods -destination generic/platform=ios | xcpretty #CocoaPods
	set -o pipefail && xcrun xcodebuild build -scheme KhulnaSoftExampleWithSPM -destination generic/platform=ios | xcpretty #SPM

format: swiftLint swiftFormat

swiftLint:
	swiftlint --fix

swiftFormat:
	swiftformat . --swiftversion 5.3

# use -test-iterations 10 if you want to run the tests multiple times
# use -only-testing:KhulnaSoftTests/KhulnaSoftQueueTest to run only a specific test
testOniOSSimulator:
	set -o pipefail && xcrun xcodebuild test -scheme KhulnaSoft -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' | xcpretty

testOnMacSimulator:
	set -o pipefail && xcrun xcodebuild test -scheme KhulnaSoft -destination 'platform=macOS' | xcpretty

test:
	set -o pipefail && swift test | xcpretty

lint:
	swiftformat . --lint --swiftversion 5.3 && swiftlint

# periphery scan --setup
# TODO: add periphery to the CI/commit prehooks
api:
	periphery scan

# requires gem and brew
# xcpretty needs 'export LANG=en_US.UTF-8'
bootstrap:
	gem install cocoapods
	gem install xcpretty
	brew install swiftlint
	brew install swiftformat
	brew install peripheryapp/periphery/periphery

# download SDKs and runtimes
# install any simulator(s) missing from runner image
# release pod
releaseCocoaPods:
	# I think we can do without these next 2 steps but let's leave it for now
	set -o pipefail && xcrun xcodebuild -downloadAllPlatforms 
	# install Apple Vision Pro
	xcrun simctl create "Apple Vision Pro" "Apple Vision Pro" "xros2.1"
	pod trunk push KhulnaSoft.podspec --allow-warnings