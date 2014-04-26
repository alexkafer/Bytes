//
//  AKGame.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKGameDelegate <NSObject>
- (void)objectAddedWithBytes: (NSInteger)bytes andImage: (UIImage *)objectImage;
@end

@interface AKGame : NSObject {
    NSTimer *gameTicker;
}

-(void)startGame;
-(void)endGame;

-(void)pauseGame;
-(void)resumeGame;

- (void)addObjectWithBytes: (NSInteger)bytes andImage: (UIImage *)objectImage;

@property (nonatomic,assign) id <AKGameDelegate> delegate;
@property (nonatomic) BOOL started;
@property (nonatomic) BOOL paused;

@end


