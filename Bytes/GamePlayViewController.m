//
//  GamePlayViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "GamePlayViewController.h"
#import "UIView+draggable.h"
#import "AKByteCounter.h"
#import "AKStyler.h"

@interface GamePlayViewController ()

@end

@implementation GamePlayViewController

@synthesize scoreView,
    mediaMenu,
    addBtn;

@synthesize currentGame;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mediaMenu = [[AKMenu alloc] init];
    self.mediaMenu.delegate = self;
    
    currentlyActiveObjects = [[NSMutableArray alloc] init];
    
    startDialog = [[StartView alloc] initFromNibStart];
    [[startDialog startGame] addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
    [startDialog setCenter:[self.view center]];
    
    pauseDialog = [[PauseView alloc] initFromNibPause];
    [[pauseDialog endGame] addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
    [[pauseDialog returnToGame] addTarget:self action:@selector(resumeGame:) forControlEvents:UIControlEventTouchUpInside];
    [pauseDialog setCenter:[self.view center]];
    
    self.currentGame = [[AKGame alloc] init];
    
    [currentGame setDelegate:self];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseGame:)];
    [tapGesture setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tapGesture];
    
    [self.view addSubview:startDialog];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self scoreView] setText:[NSString stringWithFormat:@"%d", 0]];
    [[self.addBtn.imageView layer] setCornerRadius:[self addBtn].frame.size.width/2];

    [startDialog loadView];
    [pauseDialog loadView];
}

-(void)objectAddedWithBytes:(int)bytes andImage:(UIImage *)objectImage {
    
    bytesLeft += bytes;
    
    ObjectView *objectView = [[ObjectView alloc] initWithPlayerDetail:[NSString stringWithFormat:@"%d", bytes] withUncroppedProfilePicture:objectImage];
    [currentlyActiveObjects addObject:objectView];
    
    [objectView setCenter:[self.view center]];
    
    [objectView enableDragging];
    [objectView setDraggable:YES];
    
    if ([self.delegate respondsToSelector:@selector(addObjectView:)]) {
        [(id)self.delegate addObjectView:objectView];
    }
    
    if (objectUpdater == nil) {
        objectUpdater = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                   target:self
                                                 selector:@selector(updateTick:)
                                                 userInfo:nil
                                                  repeats:YES];
    }
    
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
    NSLog(@"BytesLeft: %d active objects: %d", bytesLeft, [currentlyActiveObjects count]);
    
    if (bytesLeft < 0 && [currentlyActiveObjects count] <= 0) {
        [objectUpdater invalidate];
        objectUpdater = nil;
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

#pragma mark - Game Commands
-(void)startGame:(id)sender {
    [self.currentGame startGame];
    [startDialog removeFromSuperview];
    NSLog(@"Started");
}

-(void)pauseGame:(id)sender {
    [self.currentGame pauseGame];
    [self.view addSubview:pauseDialog];
    NSLog(@"Pause");
}

-(void)resumeGame:(id)sender {
    [self.currentGame resumeGame];
    [pauseDialog removeFromSuperview];
    NSLog(@"Resumed");
}
                                          
-(void)endGame:(id)sender {
    [self.currentGame endGame];
    [pauseDialog removeFromSuperview];
    NSLog(@"Ended");
}

#pragma mark- IBActionsx

-(void)menuPressed:(id)sender {
    [self.mediaMenu buttonsWillAnimateFromButton:sender withFrame:self.addBtn.frame inView:self.view];
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.currentGame addObjectWithBytes:[[alertView textFieldAtIndex:0].text length] andImage:[UIImage imageNamed:@"Text"]];
}

#pragma mark - DBCameraViewControllerDelegate

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    [self.currentGame addObjectWithBytes:[AKByteCounter bytesFromObject:image] andImage:image];
    
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
	[self.mediaMenu itemsWillDisapearIntoButton:self.addBtn];
    
    if (index == 1) {
        NSLog(@"Sound");
    } else if (index == 2) {
        NSLog(@"Camera");
        DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
        [cameraController setUseCameraSegue:NO];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraController];
        [nav setNavigationBarHidden:YES];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (index == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Insert Text" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        //[alert textFieldAtIndex:0].delegate = self;
        [alert show];
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
    return self.addBtn.frame.size.width/1.25;
}

@end
