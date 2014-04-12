//
//  AKTeam.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKTeam.h"

@implementation AKTeam
@synthesize teamColor, currentPlayers;

-(id)initWithTeamColor: (UIColor *)colorOfTeam {
    self = [super init];
    if (self)
    {
        teamColor = colorOfTeam;
        currentPlayers = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addPlayer:(AKPlayer *)player
{
    [currentPlayers addObject:player];
}

-(void)removePlayer:(AKPlayer *)player
{
    [currentPlayers removeObject:player];
}

@end
