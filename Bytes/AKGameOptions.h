//
//  AKGameOptions.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGame.h"

typedef enum {
    PoolPlay,
    Competitive,
    Defensive
} AKGameType;

@interface AKGameOptions : NSObject

@property (nonatomic) AKGameType *gameType;
@property (nonatomic) BOOL *isMultiplayer;
@property (nonatomic) NSNumber *maxPlayers;

@end
