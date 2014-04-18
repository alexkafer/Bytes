//
//  AKPreGame.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGame.h"

@interface AKPreGame : NSObject

@property (nonatomic) NSMutableArray *teams;

@property (nonatomic) BOOL *isMultiplayer;
@property (nonatomic) NSNumber *maxPlayers;


@end
