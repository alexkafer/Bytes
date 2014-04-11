//
//  LoadingViewController.h
//  Bytes
//
//  Created by Alex Kafer on 3/27/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    authenticating,
    fetchingprofile = 10,
    updating = 20,
    starting = 30
} LoadingStatus;

@interface LoadingViewController : UIViewController {
    LoadingStatus status;
    NSUInteger loadingCount;
    BOOL isAuthing;
    
    IBOutlet UILabel *loadingLabel;
    IBOutlet UIImageView *bytesImage;
    
    IBOutlet UILabel *ContactServerLabel;
    IBOutlet UILabel *FetchProfileLabel;
    IBOutlet UILabel *UpdatingContentLabel;
    IBOutlet UILabel *StartingAppLabel;
    
    IBOutlet UIView *authView;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIButton *loginButton;
    
    IBOutlet UIView *registerView;
    IBOutlet UITextField *regUsername;
    IBOutlet UITextField *regEmail;
    IBOutlet UITextField *regPassword;
    IBOutlet UITextField *regPasswordRepeat;
    IBOutlet UIButton *registerButton;
}

-(IBAction)registerAccount:(id)sender;
-(IBAction)login:(id)sender;
-(IBAction)submitRegistration:(id)sender;
-(IBAction)emailInfo:(id)sender;

-(void)userAuthenticated;

@end
