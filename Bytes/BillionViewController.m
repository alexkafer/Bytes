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
    
    if (objectUpdater == nil) {
        objectUpdater = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                         target:self
                                                       selector:@selector(updateTick:)
                                                       userInfo:nil
                                                        repeats:YES];
    }
}

-(void)gameTimerUpdate {
    [super gameTimerUpdate];
    NSLog(@"Update!");
}

- (void) updateTick: (id)sender {
    int scale;
    if (bytesLeft > 1000000) {
        scale = 101021;
    } else if (bytesLeft > 100000) {
        scale = 10201;
    } else if (bytesLeft > 10000) {
        scale = 1031;
    } else if (bytesLeft > 1000) {
        scale = 101;
    } else if (bytesLeft > 100) {
        scale = 11;
    } else {
        scale = 1;
    }
    
    bytesLeft -= scale;
    NSLog(@"BytesLeft: %d active objects: %d", bytesLeft, (int)[currentlyActiveObjects count]);
    
    if (bytesLeft < 0 && [currentlyActiveObjects count] <= 0) {
        [objectUpdater invalidate];
        objectUpdater = nil;
    }
    
    [currentlyActiveObjects enumerateObjectsUsingBlock:^(ObjectView *obj, NSUInteger idx, BOOL *stop) {
        NSInteger *objBytesLeft = [obj bytesLeftForObj] - scale;
        if (objBytesLeft < 0) {
            [currentlyActiveObjects removeObject:obj];
            [UIView animateWithDuration:1 animations:^{
                [obj setAlpha:0];
            }];
        } else {
            [obj setBytesLeftForObj:objBytesLeft];
            NSLog(@"Bytes Left for object: %lu", (long)objBytesLeft);
            [[obj subTextLabel] setText:[NSString stringWithFormat:@"%lu", (long)objBytesLeft]];
        }
    }];
}

@end
