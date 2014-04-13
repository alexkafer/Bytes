//
//  AKGameInstance.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKPreGame.h"
#import "AKPlayer.h"

@interface AKGame : NSObject


//@property (nonatomic) AKGameOptions *hostSetOptions;
@property (nonatomic) AKPlayer *hostPlayer;
@property (nonatomic) NSMutableArray *players;

-(id)initWithPreGameOptions: (AKPreGame *)options;

-(NSString *)validateGame;

@end
