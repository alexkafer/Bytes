//
//  AKGameManager.h
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKGame.h"

@interface AKGameManager : NSObject {
    AKGame *currentGame;
}
@property (nonatomic, retain) AKGame *currentGame;

+ (id)sharedManager;

@end
