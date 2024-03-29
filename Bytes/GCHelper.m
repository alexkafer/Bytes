//
//  GCHelper.m
//  Bytes
//
//  Created by Alex Kafer on 4/13/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GCHelper.h"

@implementation GCHelper
@synthesize gameCenterAvailable, userDisabledGameCenter, userAuthenticated;

#pragma makr Initialization
static GCHelper *sharedHelper = nil;
+ (GCHelper *)sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
}

-(id)init {
    if (self = [super init]) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
    }
    
    return self;
}

-(void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        userAuthenticated = YES;
        
        if (loadingView != nil)
        {
            [loadingView authenticateUser];
        }
        
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        userAuthenticated = NO;
    }
}

#pragma mark User Functions
- (void)authenticateLocalUser: (LoadingViewController *)view {
    if(!gameCenterAvailable || userDisabledGameCenter) {
        return;
    }
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil)
        {
            //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
            //[self showAuthenticationDialogWhenReasonable: viewController];
            [view presentViewController:viewController animated:YES completion:nil];
        }
        else if ([GKLocalPlayer localPlayer].isAuthenticated)
        {
            //authenticatedPlayer: is an example method name. Create your own method that is called after the loacal player is authenticated.
            //[self authenticatedPlayer: localPlayer];
            loadingView = view;
            [view authenticateUser];
        }
        else
        {
            userDisabledGameCenter = YES;
        }
    };
}

-(void)setGameCenterDisabled:(BOOL)disabled {
    userDisabledGameCenter = disabled;
}
@end
