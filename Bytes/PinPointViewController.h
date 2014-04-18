//
//  PinPointViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKMenu.h"
#import "DBCameraViewController.h"
#import "DBCameraContainer.h"

@interface PinPointViewController : UIViewController <AKMenuDelegate, DBCameraViewControllerDelegate>{
    IBOutlet UILabel *scoreView;
    
    IBOutlet UIButton *addBtn;
}

@property (strong, nonatomic) AKMenu *mediaMenu;
- (IBAction)buttonPressed:(id)sender;

@end
