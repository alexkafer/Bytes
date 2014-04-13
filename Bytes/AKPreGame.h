//
//  AKPreGame.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGame.h"
#import "AKGamemode.h"

@interface AKPreGame : NSObject

@property (nonatomic) AKGamemode *gameType;

@property (nonatomic) NSMutableArray *teams;

@property (nonatomic) BOOL *isMultiplayer;
@property (nonatomic) NSNumber *maxPlayers;

-(id)initWithGamemode: (AKGamemode *)gamemode;

@end
