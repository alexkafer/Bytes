//
//  MillionViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "MillionViewController.h"
#import "ObjectView.h"

@implementation MillionViewController
@synthesize mediaMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setDelegate:self];
}

-(void) addObjectView:(ObjectView *)view {
    [self.view addSubview:view];
}

-(void)objectAddedWithBytes:(int)bytes andImage:(UIImage *)objectImage{
    [super objectAddedWithBytes:bytes andImage:objectImage];
    NSLog(@"Bytes are added. What should I do?");
}

-(void)gameTimerUpdate {
    [super gameTimerUpdate];
    NSLog(@"Update!");
}

@end
