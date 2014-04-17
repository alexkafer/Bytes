//
//  MillionViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRadialMenu.h"
#import "DBCameraViewController.h"
#import "DBCameraContainer.h"

@interface MillionViewController : UIViewController <ALRadialMenuDelegate, DBCameraViewControllerDelegate> {
    IBOutlet UILabel *scoreView;
    
    IBOutlet UIButton *addBtn;
}

@property (strong, nonatomic) ALRadialMenu *mediaMenu;
- (IBAction)buttonPressed:(id)sender;

@end
