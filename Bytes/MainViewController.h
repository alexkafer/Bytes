//
//  MainViewController.h
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MainViewController : UIViewController <UIAlertViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate> {
    UILabel *scrollingText;
    UIBarButtonItem *profile;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *profile;

- (IBAction)updateProfile:(id)sender;

@end
