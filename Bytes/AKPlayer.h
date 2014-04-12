//
//  AKPlayer.h
//  Bytes
//
//  Created by Alex Kafer on 3/30/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSetupPlayerView.h"

@interface AKPlayer : NSObject

@property (nonatomic, retain) NSString *accountName;
@property (nonatomic, retain) UIImage *profileImage;

@property (nonatomic) BOOL *isOffline;
@property (nonatomic) BOOL *isCurrent;

-(id)initWithUsername: (NSString *)user andGravatarEmail: (NSString *)gravMail;
-(id)initWithUsername: (NSString *)user andProfilePicture: (UIImage *)profile;


-(GameSetupPlayerView *)getPlayerProfileView;

@end
