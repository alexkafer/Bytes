//
//  AKGameInstance.m
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKGame.h"

@implementation AKGame
@synthesize hostPlayer, players;

-(id)initWithPreGameOptions: (AKPreGame *)options {
    if (self = [super init])
    {
        //hostPlayer = options;
        //hostSetOptions = options;
        //players = otherPlayers;
    }
    return self;
}

-(NSString *)validateGame {
    NSString static *successMessage = @"Success";
    if (![hostPlayer isOffline] && hostPlayer) {
        return successMessage;
    }
    return @"An Unknow Error Occurred";
}
@end
