//
//  GCHelper.h
//  Bytes
//
//  Created by Alex Kafer on 4/13/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "LoadingViewController.h"

@interface GCHelper : NSObject {
    
    BOOL userDisabledGameCenter;
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    LoadingViewController *loadingView;
}

@property (assign, readonly) BOOL userDisabledGameCenter;
@property (assign, readonly) BOOL gameCenterAvailable;
@property (assign, readonly) BOOL userAuthenticated;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser: (LoadingViewController *)view;
- (void)setGameCenterDisabled: (BOOL)disabled;

@end
