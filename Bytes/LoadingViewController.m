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
#import "UIView+draggable.h"
#import "GCHelper.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    authView = [[AuthView alloc] initFromNib];
    [authView loadView];
    [authView setHidden:YES];
    [authView setCenter:self.view.center];
    
    [authView.loginButton addTarget:self action:@selector(loginWithGameCenter:) forControlEvents:UIControlEventTouchUpInside];
    [authView.cancelButton addTarget:self action:@selector(cancelWithGameCenter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:authView];
    
    
    [authView enableDragging];
    [authView setDraggable:YES];
    
    loadingLabel.text = @"1";
    loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                    target:self
                                                  selector:@selector(typeALetter)
                                                  userInfo:nil
                                                   repeats:YES];
    

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [bytesImage setCenter:CGPointMake([bytesImage center].x, [bytesImage center].y-20)];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done Loading!");
                         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                         [self authenticateUser];
                     }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if (isAuthing) {
        UIView *touchedView = [touch view];
        if ([touchedView isEqual:self.view]) {
            [self.view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj endEditing:YES];
            }];
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Methods

- (void)typeALetter {
    int nextDigit = arc4random_uniform(2);
    
    if (!loadingReturning && loadingLabel.text.length <= 34) {
        loadingLabel.text = [loadingLabel.text stringByAppendingFormat:@"%d", nextDigit];
    } else {
        loadingReturning = true;
        if (loadingLabel.text.length == 0) {
            loadingReturning = false;
        } else {
            loadingLabel.text = [loadingLabel.text substringToIndex:[loadingLabel.text length] - 1];
        }
    }
    
}

-(void)play {
    [UIView animateWithDuration:0.5 animations:^{
        [bytesImage setAlpha:0];
        [loadingLabel setAlpha:0];
    } completion:^(BOOL finished) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        MainViewController *main = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        [self presentViewController:main animated:NO completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }];
    }];
}





#pragma mark Authentication

-(void)authenticateUser {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        isAuthing = NO;
        [self play];
    } else {
        [authView setCenter:self.view.center];
        [authView setHidden:NO];
        isAuthing = YES;
    }
}

#pragma mark - IBActions

-(IBAction)loginWithGameCenter:(id)sender {
    [[GCHelper sharedInstance] authenticateLocalUser:self];
    
    [UIView animateWithDuration:1 animations:^{
        [authView setAlpha:0];
        [authView setCenter:CGPointMake(0, [self.view center].y)];
    } completion:^(BOOL finished) {
        [authView setHidden:YES];
    }];
    
    
}

-(IBAction)cancelWithGameCenter:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        [authView setAlpha:0];
        [authView setCenter:CGPointMake(0, [self.view center].y)];
    } completion:^(BOOL finished) {
        [authView setHidden:YES];
    }];
    
    [[GCHelper sharedInstance] setGameCenterDisabled:YES];
    [self play];
}

@end
