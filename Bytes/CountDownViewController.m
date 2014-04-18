//
//  CountDownViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "CountDownViewController.h"
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
    
    self.mediaMenu = [[ALRadialMenu alloc] init];
    self.mediaMenu.delegate = self;
    
    totalBytes = 0;
    // Do any additional setup after loading the view.
}

- (IBAction)buttonPressed:(id)sender {
	//the button that brings the items into view was pressed
	[self.mediaMenu buttonsWillAnimateFromButton:sender withFrame:addBtn.frame inView:self.view];
}

#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
	return 3;
}


- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	return 180;
}


- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	return 80;
}


- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
    CGRect rect = CGRectMake(0, 0, 200, 200);
	switch (index) {
        case 1: return [AKStyler circularScaleAndCropImage:[UIImage imageNamed:@"Sound"] frame:rect];
        case 2: return [AKStyler circularScaleAndCropImage:[UIImage imageNamed:@"Camera"] frame:rect];
        default: return [AKStyler circularScaleAndCropImage:[UIImage imageNamed:@"Text"] frame:rect];
    }
}


- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
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

- (void) radialMenu:(ALRadialMenu *)radialMenu didReleaseButton:(ALRadialButton *)button AfterDragAtIndex:(NSInteger)index {
    self.mediaMenu = [[ALRadialMenu alloc] init];
    self.mediaMenu.delegate = self;
}

-(NSInteger)arcStartForRadialMenu:(ALRadialMenu *)radialMenu {
    return 180;
}

-(float)buttonSizeForRadialMenu:(ALRadialMenu *)radialMenu {
    return addBtn.frame.size.width/1.25;
}

#pragma mark - DBCameraViewControllerDelegate

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImage:image];
    
    CALayer *layer = imageView.layer;
    
    [layer setBorderColor:[UIColor whiteColor].CGColor];
    [layer setBorderWidth:2];
    
    [imageView setCenter:[self.view center]];
    [self.view addSubview:imageView];
    
    [imageView enableDragging];
    [imageView setDraggable:YES];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(increaseNumber:)
                                   userInfo:nil
                                    repeats:YES];
    
    bytesLeft = [ByteCounter bytesFromObject:image];
    
    [UIView animateWithDuration:120 animations:^{
        [imageView setAlpha:0];
    }];
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
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
    NSLog(@"Scale: %d Left: %d Total %d", scale, bytesLeft, totalBytes);
    totalBytes += scale;
    bytesLeft -= scale;
    scoreView.text = [NSString stringWithFormat:@"%d", totalBytes];
    
    if (bytesLeft < 0) {
        [timer invalidate];
        timer = nil;
    }
}


@end
