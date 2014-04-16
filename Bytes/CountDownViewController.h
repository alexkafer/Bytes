//
//  CountDownViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRadialMenu.h"

@interface CountDownViewController : UIViewController <ALRadialMenuDelegate>{
    IBOutlet UILabel *scoreView;
    
    IBOutlet UIButton *addBtn;
}

@property (strong, nonatomic) ALRadialMenu *mediaMenu;
- (IBAction)buttonPressed:(id)sender;

@end
