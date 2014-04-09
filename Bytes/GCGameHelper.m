//
//  GCGameHelper.m
//  Bytes
//
//  Created by Alex Kafer on 3/29/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GCGameHelper.h"
#import "LoadingViewController.h"

@implementation GCGameHelper

@synthesize gameCenterAvailable;

#pragma mark - Initialization of shared instance

static GCGameHelper *sharedHelper = nil;
+ (GCGameHelper *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCGameHelper alloc] init];
    }
    return sharedHelper;
}

#pragma mark - Availability Methods
- (BOOL)isGameCenterAvailable {
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    NSString *currentsSystemVersion = [[UIDevice currentDevice] systemVersion];
    return (gcClass && ([currentsSystemVersion compare:@"4.1" options:NSNumericSearch] != NSOrderedAscending));
}

#pragma mark - Custom Methods

- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated &&
        !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated &&
               userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
    
}

#pragma mark User functions

-(void)authenticateLocalUserWithView: (LoadingViewController *)parentViewCont {
    
    if (!gameCenterAvailable) return;
    
    [GKLocalPlayer localPlayer].authenticateHandler = ^(UIViewController *viewController,NSError *error) {
        if ([GKLocalPlayer localPlayer].authenticated) {
            //already authenticated
            NSLog(@"Authed already");
            [parentViewCont userAuthenticated];
        } else if(viewController) {
            
            [parentViewCont presentViewController:viewController animated:YES completion:^(void){
                [parentViewCont userAuthenticated];
            }];
            
            //present the login form
        } else {
            NSLog(@"Failed Auth - %hhd", [GKLocalPlayer localPlayer].isAuthenticated);
            [parentViewCont userAuthenticated];
            //problem with authentication,probably bc the user doesn't use Game Center
        }
    };
}

@end
