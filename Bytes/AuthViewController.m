//
//  AuthViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AuthViewController.h"
#import "AKStyler.h"
#import <Parse/Parse.h>
#import "LoadingViewController.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AKStyler styleLayer:loginButton.layer opacity:0.1 fancy:NO];
    // Do any additional setup after loading the view from its nib.
}

//
#pragma mark - IBActions
- (IBAction) registerAccount:(id)sender {
    NSLog(@"Register");
}

- (IBAction)login:(id)sender {
    [PFUser logInWithUsernameInBackground:username.text password:password.text block:^(PFUser *user, NSError *error) {
        if (user) {
            // Do stuff after successful login.
            LoadingViewController *loadingView = (LoadingViewController *)self.view.superview;
            [loadingView userAuthenticated];
        } else {
            // The login failed. Check error to see why.
            NSLog(@"Errored, %@", error);
        }
    }];
}

@end
