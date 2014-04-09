//
//  GameplayViewController.h
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameplayViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate> {
    IBOutlet UILabel *scoreLabel;
    int bytesCollected;
}

@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;

-(IBAction)showMediaSelect:(id)sender;

@end
