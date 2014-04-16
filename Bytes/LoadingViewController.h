//
//  LoadingViewController.h
//  Bytes
//
//  Created by Alex Kafer on 3/27/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthView.h"

@interface LoadingViewController : UIViewController {
    BOOL isAuthing;
    
    IBOutlet UILabel *loadingLabel;
    IBOutlet UIImageView *bytesImage;
    
    NSTimer *loadingTimer;
    NSString *loadingString;
    NSUInteger loadingIndex;
}

@property (nonatomic, retain) IBOutlet AuthView *authView;

-(void)userAuthenticated;

@end
