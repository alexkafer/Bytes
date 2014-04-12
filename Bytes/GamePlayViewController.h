//
//  GamePlayViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRadialMenu.h"

@interface GamePlayViewController : UIViewController <ALRadialMenuDelegate>{
    
    IBOutlet UILabel *scoreView;
    
    IBOutlet UIView *mediaView;
    IBOutlet UIButton *addBtn;
}

@property (strong, nonatomic) ALRadialMenu *mediaMenu;
- (IBAction)buttonPressed:(id)sender;

@end
