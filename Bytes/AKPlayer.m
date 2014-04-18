//
//  AKPlayer.m
//  Bytes
//
//  Created by Alex Kafer on 3/30/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKPlayer.h"
#import "AKGravatar.h"

@implementation AKPlayer
@synthesize accountName, profileImage;

-(id)initWithUsername:(NSString *)user andProfilePicture:(UIImage *)profile {
    self = [super init];
    if (self) {
        accountName = user;
        profileImage = profile;
    }
    return self;
}

-(id)initWithUsername:(NSString *)user andGravatarEmail:(NSString *)gravMail {
    self = [super init];
    if (self) {
        accountName = user;
        profileImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[AKGravatar getGravatarURL:gravMail withSize:200]]];
    }
    return self;
}

-(ObjectView *)getPlayerProfileView {
    UIImage *profilePic = profileImage;
    
    if (profilePic == nil) {
        profilePic = [UIImage imageNamed:@"userAccount"];
    }
    
    ObjectView *playerProfile = [[ObjectView alloc] initWithPlayerDetail:@"You (Host)" withUncroppedProfilePicture:profilePic];
    [playerProfile loadView];
    
    return playerProfile;
}

@end
