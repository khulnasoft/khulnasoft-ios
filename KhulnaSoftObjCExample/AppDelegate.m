//
//  AppDelegate.m
//  KhulnaSoftObjCExample
//
//  Created by Manoel Aranda Neto on 23.10.23.
//

#import "AppDelegate.h"
#import <KhulnaSoft/KhulnaSoft.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)receiveTestNotification {
    NSLog(@"received");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(receiveTestNotification)
            name:KhulnaSoftSDK.didStartNotification
            object:nil];

    KhulnaSoftConfig *config = [[KhulnaSoftConfig alloc] apiKey:@"_6SG-F7I1vCuZ-HdJL3VZQqjBlaSb1_20hDPwqMNnGI"];
    config.preloadFeatureFlags = YES;
    [[KhulnaSoftSDK shared] debug:YES];
    [[KhulnaSoftSDK shared] setup:config];
    
    NSString *event = @"theEvent";
    NSString *distinctId = @"theCustomDistinctId";
    NSDictionary *properties = @{@"source": @"iOS App", @"state": @"running"};
    NSDictionary *userProperties = @{@"userAlive": @YES, @"userAge": @50};
    NSDictionary *userPropertiesSetOnce = @{@"signupDate": @"2024-10-16"};
    NSDictionary *groups = @{@"groupName": @"developers"};

    [[KhulnaSoftSDK shared] captureWithEvent:event
                               distinctId:distinctId
                               properties:properties
                            userProperties:userProperties
                    userPropertiesSetOnce:userPropertiesSetOnce
                                   groups:groups
    ];
    
    [[KhulnaSoftSDK shared] captureWithEvent:event
                               properties:properties
                            userProperties:userProperties
                    userPropertiesSetOnce:userPropertiesSetOnce
    ];
    
    NSLog(@"getDistinctId: %@", [[KhulnaSoftSDK shared] getDistinctId]);
    NSLog(@"getAnonymousId: %@", [[KhulnaSoftSDK shared] getAnonymousId]);
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    props[@"state"] = @"running";

    NSMutableDictionary *userProps = [NSMutableDictionary dictionary];
    userProps[@"userAge"] = @50;
    
    NSMutableDictionary *userPropsOnce = [NSMutableDictionary dictionary];
    userPropsOnce[@"userAlive"] = @YES;
    
    NSMutableDictionary *groupProps = [NSMutableDictionary dictionary];
    groupProps[@"groupName"] = @"theGroup";

    NSMutableDictionary *registerProps = [NSMutableDictionary dictionary];
    props[@"loggedIn"] = @YES;
    [[KhulnaSoftSDK shared] registerProperties:registerProps];
    [[KhulnaSoftSDK shared] unregisterProperties:@"test2"];
    
    [[KhulnaSoftSDK shared] identify:@"my_new_id"];
    [[KhulnaSoftSDK shared] identifyWithDistinctId:@"my_new_id" userProperties:userProps];
    [[KhulnaSoftSDK shared] identifyWithDistinctId:@"my_new_id" userProperties:userProps userPropertiesSetOnce:userPropsOnce];
    
    
    [[KhulnaSoftSDK shared] optIn];
    [[KhulnaSoftSDK shared] optOut];
    NSLog(@"isOptOut: %d", [[KhulnaSoftSDK shared] isOptOut]);
    NSLog(@"isFeatureEnabled: %d", [[KhulnaSoftSDK shared] isFeatureEnabled:@"myFlag"]);
    NSLog(@"getFeatureFlag: %@", [[KhulnaSoftSDK shared] getFeatureFlag:@"myFlag"]);
    NSLog(@"getFeatureFlagPayload: %@", [[KhulnaSoftSDK shared] getFeatureFlagPayload:@"myFlag"]);
    
    [[KhulnaSoftSDK shared] reloadFeatureFlags];
    [[KhulnaSoftSDK shared] reloadFeatureFlagsWithCallback:^(){
        NSLog(@"called");
    }];
    
    [[KhulnaSoftSDK shared] capture:@"theEvent"];

    [[KhulnaSoftSDK shared] captureWithEvent:@"theEvent"
                               properties:props];

    [[KhulnaSoftSDK shared] captureWithEvent:@"theEvent"
                               properties:props
                          userProperties:userProps];

    [[KhulnaSoftSDK shared] captureWithEvent:@"theEvent"
                               properties:props
                          userProperties:userProps
                 userPropertiesSetOnce:userPropsOnce];

    [[KhulnaSoftSDK shared] captureWithEvent:@"theEvent"
                              distinctId:@"custom_distinct_id"
                               properties:props
                          userProperties:userProps
                 userPropertiesSetOnce:userPropsOnce
                                 groups:groupProps];

    [[KhulnaSoftSDK shared] captureWithEvent:@"theEvent"
                              distinctId:@"custom_distinct_id"
                               properties:props
                          userProperties:userProps
                 userPropertiesSetOnce:userPropsOnce
                                 groups:groupProps
                              timestamp:[NSDate date]];


    [[KhulnaSoftSDK shared] groupWithType:@"theType" key:@"theKey"];
    [[KhulnaSoftSDK shared] groupWithType:@"theType" key:@"theKey" groupProperties:groupProps];
    
    [[KhulnaSoftSDK shared] alias:@"theAlias"];
    
    [[KhulnaSoftSDK shared] screen:@"theScreen"];
    [[KhulnaSoftSDK shared] screenWithTitle:@"theScreen" properties:props];
    
    [[KhulnaSoftSDK shared] flush];
    [[KhulnaSoftSDK shared] reset];
    [[KhulnaSoftSDK shared] close];

    KhulnaSoftSDK *khulnaSoft = [KhulnaSoftSDK with:config];
    
    [khulnaSoft capture:@"theCapture"];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
