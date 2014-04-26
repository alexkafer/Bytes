//
//  PinPointViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "PinPointViewController.h"
#import "ObjectView.h"

@implementation PinPointViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super setDelegate:self];
    [[super subLabel] setText:[NSString stringWithFormat:@"%ld", (long)self.targetGoal]];
}

-(void) addObjectView:(ObjectView *)view {
    [self.view addSubview:view];
}

-(void)objectAddedWithBytes:(NSInteger)bytes andImage:(UIImage *)objectImage{
    [super objectAddedWithBytes:bytes andImage:objectImage];
}

-(void)gameTick {
    NSLog(@"Update!");
}
@end
