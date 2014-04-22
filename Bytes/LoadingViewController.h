//
//  LoadingViewController.h
//  Bytes
//
//  Created by Alex Kafer on 3/27/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthView.h"
#import "ObjectView.h"

@interface LoadingViewController : UIViewController {
    BOOL waitingWithPlayer;
    ObjectView *player;
    
    IBOutlet UILabel *loadingLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet UIImageView *bytesImage;
    
    AuthView *authView;
    
    NSTimer *loadingTimer;
    BOOL loadingReturning;
}

-(void)authenticateUser;

@end
