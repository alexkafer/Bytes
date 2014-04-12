//
//  GameSetupViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSetupViewController : UIViewController {
    IBOutlet UIImageView *profileView;
    IBOutlet UIImageView *addPlayer;
    
    IBOutlet UIView *inviteView;
    IBOutlet UITextField *inviteSearch;
    
    IBOutlet UIView *managerView;
    IBOutlet UIButton *managerButton;
    
    NSMutableArray *players;
    BOOL isAdding;
}
@end
