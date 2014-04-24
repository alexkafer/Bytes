//
//  LoadingViewController.m
//  Bytes
//
//  Created by Alex Kafer on 3/27/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "LoadingViewController.h"
#import "MainViewController.h"
#import "AKStyler.h"
#import "GCHelper.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    authView = [[AuthView alloc] initFromNib];
    [authView loadView];
    [authView startDragging];
    [authView setHidden:YES];
    [authView setCenter: CGPointMake([self.view center].x, [self.view center].y+40)];
    
    [authView.loginButton addTarget:self action:@selector(loginWithGameCenter:) forControlEvents:UIControlEventTouchUpInside];
    [authView.cancelButton addTarget:self action:@selector(cancelWithGameCenter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:authView];
}

-(void)viewDidAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self authenticateUser];
    loadingLabel.text = @"1";
    loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                    target:self
                                                  selector:@selector(typeALetter)
                                                  userInfo:nil
                                                   repeats:YES];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (waitingWithPlayer) {
        [UIView animateWithDuration:0.5 animations:^{
            [player setAlpha:0];
            [player setCenter:CGPointMake(0, [player center].y)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [bytesImage setAlpha:0];
                [loadingLabel setAlpha:0];
            } completion:^(BOOL finished) {
                waitingWithPlayer = NO;
                [self beginGame];
            }];
            
        }];
    }
}

#pragma mark - Internal Methods

- (void)typeALetter {
    //int nextDigit = arc4random_uniform(2);
    
    if (!loadingReturning && loadingLabel.text.length <= 34) {
        loadingLabel.text = [loadingLabel.text stringByAppendingFormat:@"%d", (int)arc4random_uniform(2)];
    } else {
        loadingReturning = true;
        if (loadingLabel.text.length == 0) {
            loadingReturning = false;
        } else {
            loadingLabel.text = [loadingLabel.text substringToIndex:[loadingLabel.text length] - 1];
        }
    }
    
}

-(void)beginGame {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MainViewController *main = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    [self presentViewController:main animated:NO completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}

- (void)animateNewPlayer {
    [[GKLocalPlayer localPlayer] loadPhotoForSize:GKPhotoSizeNormal withCompletionHandler:^(UIImage *photo, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error debugDescription]);
        } //[self play];
        
        player = [[ObjectView alloc] initWithPlayerDetail:[[GKLocalPlayer localPlayer] alias] withUncroppedProfilePicture:photo];
        [player setAlpha:0];
        [player setCenter:[self.view center]];
        [self.view addSubview:player];
        
        [UIView animateWithDuration:0.5 animations:^{
            [player setAlpha:1];
        } completion:^(BOOL finished) {
            waitingWithPlayer = YES;
        }];
    }];
    
}



#pragma mark Authentication

-(void)authenticateUser {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        //[self play];
        [self animateNewPlayer];
        
    } else {
        [authView setHidden:NO];
    }
}

#pragma mark - IBActions

-(IBAction)loginWithGameCenter:(id)sender {
    [[GCHelper sharedInstance] authenticateLocalUser:self];
    
    [UIView animateWithDuration:1 animations:^{
        [authView setAlpha:0];
        [authView setCenter:CGPointMake(0, [authView center].y)];
    } completion:^(BOOL finished) {
        [authView setHidden:YES];
    }];
    
    
}

-(IBAction)cancelWithGameCenter:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        [authView setAlpha:0];
        [authView setCenter:CGPointMake(0, [authView center].y)];
    } completion:^(BOOL finished) {
        [authView setHidden:YES];
    }];
    
    [[GCHelper sharedInstance] setGameCenterDisabled:YES];
    [UIView animateWithDuration:0.5 animations:^{
        [bytesImage setAlpha:0];
        [loadingLabel setAlpha:0];
    } completion:^(BOOL finished) {
        [self beginGame];
    }];
    
}

@end
