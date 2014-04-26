//
//  CountDownViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "CountDownViewController.h"
#import "ObjectView.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setDelegate:self];
}

-(void) addObjectView:(ObjectView *)view {
    [self.view addSubview:view];
}

-(void)objectAddedWithBytes:(NSInteger)bytes andImage:(UIImage *)objectImage{
    [super objectAddedWithBytes:bytes andImage:objectImage];
}

-(void)gameTick {
    if (![super currentGame].paused && secondsLeft >= 0) {
        secondsLeft--;
    }
    
    if (secondsLeft <= 0) {
        [[super currentGame] endGame];
    } else {
        [[super subLabel] setText:[NSString stringWithFormat:@"%d", secondsLeft]];
    }
}

@end
