//
//  AKGameManager.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKGameManager.h"

@implementation AKGameManager
@synthesize currentGame;

+ (id)sharedManager {
    static AKGameManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        currentGame = nil;
    }
    return self;
}

@end
