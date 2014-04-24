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
#import "MainViewController.h"

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
    [[startDialog backMenu] addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
    [startDialog setCenter:[self.view center]];
    
    pauseDialog = [[PauseView alloc] initFromNibPause];
    [[pauseDialog endGame] addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
    [[pauseDialog returnToGame] addTarget:self action:@selector(resumeGame:) forControlEvents:UIControlEventTouchUpInside];
    [pauseDialog setCenter:[self.view center]];
    
    self.currentGame = [[AKGame alloc] init];
    
    [currentGame setDelegate:self];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseGame:)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:tapGesture];
    
    darkCurtain = [[UIView alloc]initWithFrame:self.view.frame];
    [darkCurtain setBackgroundColor:[UIColor blackColor]];
    [darkCurtain setAlpha:0.5];
    
    [pauseDialog setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self scoreView] setText:[NSString stringWithFormat:@"%d", 0]];
    [[self.addBtn.imageView layer] setCornerRadius:[self addBtn].frame.size.width/2];

    [startDialog loadView];
    [pauseDialog loadView];
    
    [self.view addSubview:darkCurtain];
    [self.view addSubview:startDialog];
    [self.view addSubview:pauseDialog];
    
}

-(void)objectAddedWithBytes:(NSInteger)bytes andImage:(UIImage *)objectImage {
    
    ObjectView *objectView = [[ObjectView alloc] initWithPlayerDetail:[NSString stringWithFormat:@"%ld", (long)bytes] withUncroppedProfilePicture:objectImage];
    [currentlyActiveObjects addObject:objectView];
    
    [objectView setCenter:[self.view center]];
    
    [objectView enableDragging];
    [objectView setDraggable:YES];
    
    if ([self.delegate respondsToSelector:@selector(addObjectView:)]) {
        [(id)self.delegate addObjectView:objectView];
    }
}

#pragma mark - Game Commands
-(void)startGame:(id)sender {
    [self.currentGame startGame];
    [UIView animateWithDuration:0.3 animations:^{
        [startDialog setAlpha:0];
        [darkCurtain setAlpha:0];
    } completion:^(BOOL finished) {
        [startDialog setHidden:YES];
        [darkCurtain setHidden:YES];
    }];
    NSLog(@"Started");
}

-(void)pauseGame:(id)sender {
    if ([startDialog isHidden]) {
        [self.currentGame pauseGame];
        [pauseDialog setHidden:NO];
        [darkCurtain setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            [pauseDialog setAlpha:1];
            [darkCurtain setAlpha:0.5];
        }];
        NSLog(@"Pause");
    }
}

-(void)resumeGame:(id)sender {
    [self.currentGame resumeGame];
    [UIView animateWithDuration:0.3 animations:^{
        [pauseDialog setAlpha:0];
        [pauseDialog setAlpha:0];
    } completion:^(BOOL finished) {
        [pauseDialog setHidden:YES];
        [darkCurtain setHidden:YES];
    }];
    NSLog(@"Resumed");
}
                                          
-(void)endGame:(id)sender {
    [self.currentGame endGame];
    
    [UIView animateWithDuration:0.3 animations:^{
        [pauseDialog setAlpha:0];
        [darkCurtain setAlpha:0];
    } completion:^(BOOL finished) {
        [pauseDialog setHidden:YES];
        [darkCurtain setHidden:YES];
    }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MainViewController *main = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    [main setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:main animated:YES completion:nil];
    
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
