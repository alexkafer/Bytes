//
//  AuthViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIButton *loginButton;
}

-(IBAction)registerAccount:(id)sender;
-(IBAction)login:(id)sender;

@end
