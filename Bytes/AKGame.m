//
//  AKGame.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKGame.h"

@implementation AKGame

#pragma mark - Game Timer Commands
-(void)startGame {
    gameTicker = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(gameTick) userInfo:nil repeats:YES];
}

-(void)pauseGame {
    if (![self paused]) {
        [self setPaused:YES];
    }
}

-(void)resumeGame {
    if ([self paused]) {
        [self setPaused:NO];
    }
}

-(void)endGame {
    [gameTicker invalidate];
    gameTicker = nil;
}

#pragma mark - Game Byte Management

- (void)addObjectWithBytes: (NSInteger)bytes andImage: (UIImage *)objectImage {
    if (![self paused] && [self.delegate respondsToSelector:@selector(objectAddedWithBytes:andImage:)]) {
        [(id)self.delegate objectAddedWithBytes:bytes andImage:objectImage];
    }
}

#pragma mark - Game Actions
-(void) gameTick {
    if (![self paused] && [self.delegate respondsToSelector:@selector(gameTimerUpdate)]) {
        [(id)self.delegate gameTimerUpdate];
    }
}

@end
