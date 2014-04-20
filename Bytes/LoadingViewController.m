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
                                                  selector:@selector(typeALetter:)
                                                  userInfo:nil
                                                   repeats:YES];
    //FIXME loading label FIXME
    loadingIndex = 0;
    

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
                         [self startLoadingSequence];
                     }];
    
    [AKStyler styleLayer:playButton.layer opacity:0.1 fancy:NO];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Loading Methods

- (void)typeALetter:(id)sender {
    NSString *nextDigit;
    if ([self getYesOrNo]) {
        nextDigit = @"1";
    } else {
        nextDigit = @"0";
    }
    loadingLabel.text = [loadingLabel.text stringByAppendingFormat:@"%@", nextDigit];
    if (loadingIndex < 100) {
        loadingIndex++;
        loadingLabel.alpha =- 0.01;
    } else {
        loadingIndex = 0;
        loadingLabel.alpha = 1;
        loadingLabel.text = @"";
    }
    
}

-(BOOL) getYesOrNo
{
    int tmp = arc4random_uniform(2);
    if (tmp >= 1) {
        return YES;
    }
    return NO;
}

-(void)completed {
    [authView setHidden:YES];
    [playButton setAlpha:0];
    [playButton setHidden:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        [playButton setAlpha:1];
    }];
}

-(IBAction)play:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        loadingLabel.center = CGPointMake(loadingLabel.center.x, loadingLabel.center.y+160);
        [bytesImage setCenter:CGPointMake(bytesImage.center.x, bytesImage.center.y-220)];
    } completion:^(BOOL finished) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        MainViewController *main = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        [self presentViewController:main animated:NO completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }];
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



#pragma mark Authentication

- (void) showAuthentication {
        [authView setCenter:self.view.center];
        [authView setHidden:NO];
        isAuthing = YES;
}

-(void) startLoadingSequence {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        NSLog(@"Authed!");
        [self userAuthenticated];
    } else {
         NSLog(@"Showing Auth!");
        [self showAuthentication];
    }
}

-(void)userAuthenticated {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        isAuthing = NO;
         NSLog(@"Complete");
        [self completed];
    } else {
        [self showAuthentication];
    }
}

#pragma mark - IBActions

-(IBAction)loginWithGameCenter:(id)sender {
    [[GCHelper sharedInstance] authenticateLocalUser:self];
}

-(IBAction)cancelWithGameCenter:(id)sender {
    [[GCHelper sharedInstance] setGameCenterDisabled:YES];
    [self completed];
}

@end
