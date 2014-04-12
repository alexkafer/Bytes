//
//  AKTeam.h
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKPlayer.h"
@class AKPlayer;

@interface AKTeam : NSObject

@property (nonatomic, retain)  NSMutableArray *currentPlayers;
@property (nonatomic, retain) UIColor* teamColor;

-(id)initWithTeamColor: (UIColor *)teamColor;

-(void)addPlayer: (AKPlayer *)player;
-(void)removePlayer: (AKPlayer *)player;

@end
