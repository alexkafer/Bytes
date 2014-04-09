//
//  GCGameHelper.h
//  Bytes
//
//  Created by Alex Kafer on 3/29/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCGameHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCGameHelper *)sharedInstance;
-(void)authenticateLocalUserWithView: (UIViewController *)parentViewCont;

@end
