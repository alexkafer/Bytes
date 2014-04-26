//
//  MillionViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "BillionViewController.h"
#import "ObjectView.h"

@implementation BillionViewController
@synthesize mediaMenu;

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
    NSLog(@"Update! Billion");
}
@end
