//
//  CountDownViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "CountDownViewController.h"
#import "ObjectView.h"
#import "UIView+draggable.h"
#import "AKGravatar.h"
#import "AKStyler.h"
#import "ByteCounter.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [addBtn.imageView.layer setCornerRadius:addBtn.frame.size.width/2];
    
    self.mediaMenu = [[AKMenu alloc] init];
    self.mediaMenu.delegate = self;
    
    currentlyActiveObjects = [[NSMutableArray alloc] init];
    
    scoreView.text = [NSString stringWithFormat:@"%d", 0];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonPressed:(id)sender {
	//the button that brings the items into view was pressed
	[self.mediaMenu buttonsWillAnimateFromButton:sender withFrame:addBtn.frame inView:self.view];
}

#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(AKMenu *)radialMenu {
	return 3;
}


- (NSInteger) arcSizeForRadialMenu:(AKMenu *)radialMenu {
	return 180;
}


- (NSInteger) arcRadiusForRadialMenu:(AKMenu *)radialMenu {
	return 80;
}


- (UIImage *) radialMenu:(AKMenu *)radialMenu imageForIndex:(NSInteger) index {
    CGRect rect = CGRectMake(0, 0, 200, 200);
	switch (index) {
        case 1: return [AKStyler circularScaleAndCropImage:[UIImage imageNamed:@"Sound"] frame:rect];
        case 2: return [AKStyler circularScaleAndCropImage:[UIImage imageNamed:@"Camera"] frame:rect];
        default: return [AKStyler circularScaleAndCropImage:[UIImage imageNamed:@"Text"] frame:rect];
    }
}


- (void) radialMenu:(AKMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
	[self.mediaMenu itemsWillDisapearIntoButton:addBtn];
    
    if (index == 1) {
        NSLog(@"Sound");
    } else if (index == 2) {
        NSLog(@"Camera");
        DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
        [cameraController setUseCameraSegue:NO];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraController];
        [nav setNavigationBarHidden:YES];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (index == 4) {
        NSLog(@"Text");
    }
}

- (void) radialMenu:(AKMenu *)radialMenu didReleaseButton:(AKMenu *)button AfterDragAtIndex:(NSInteger)index {
    self.mediaMenu = [[AKMenu alloc] init];
    self.mediaMenu.delegate = self;
}

-(NSInteger)arcStartForRadialMenu:(AKMenu *)radialMenu {
    return 180;
}

-(float)buttonSizeForRadialMenu:(AKMenu *)radialMenu {
    return addBtn.frame.size.width/1.25;
}

#pragma mark - DBCameraViewControllerDelegate

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Guess what");
    bytesLeft += [ByteCounter bytesFromObject:image];
    
    ObjectView *objectView = [[ObjectView alloc] initWithPlayerDetail:[NSString stringWithFormat:@"%d", bytesLeft] withUncroppedProfilePicture:image];
    
    [objectView setBytesLeftForObj:(NSInteger*)bytesLeft];
    [currentlyActiveObjects addObject:objectView];
     
    [objectView setCenter:[self.view center]];
    
    [objectView enableDragging];
    [objectView setDraggable:YES];
    
    [self.view addSubview:objectView];
    
    
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(increaseNumber:)
                                   userInfo:nil
                                    repeats:YES];
    }
    
}

- (void) increaseNumber: (id)sender {
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
    totalBytes += scale;
    bytesLeft -= scale;
    scoreView.text = [NSString stringWithFormat:@"%d", totalBytes];
    NSLog(@"BytesLeft: %d active objects: %d", bytesLeft, [currentlyActiveObjects count]);
    if (bytesLeft < 0 && [currentlyActiveObjects count] <= 0) {
        [timer invalidate];
        timer = nil;
    }
    
    [currentlyActiveObjects enumerateObjectsUsingBlock:^(ObjectView *obj, NSUInteger idx, BOOL *stop) {
        int bytesLeftForObj = (int)[obj bytesLeftForObj] - scale;
        if (bytesLeftForObj < 0) {
            [currentlyActiveObjects removeObject:obj];
            [UIView animateWithDuration:1 animations:^{
                [obj setAlpha:0];
            }];
        } else {
            [obj setBytesLeftForObj:(NSInteger *)(bytesLeftForObj)];
            NSLog(@"Bytes Left for object: %d", bytesLeftForObj);
            [[obj subTextLabel] setText:[NSString stringWithFormat:@"%d", bytesLeftForObj]];
        }
    }];
}


@end
