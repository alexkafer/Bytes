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
}

-(IBAction)registerAccount:(id)sender;
-(IBAction)login:(id)sender;

-(void)userAuthenticated;

@end
