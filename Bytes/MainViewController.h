//
//  MainViewController.h
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UISegmentedControl *segControl;
    IBOutlet UIButton *whatAreBytesBtn;
    
    NSMutableArray *cardViewControllers;
}

-(IBAction)scrollWith:(id)sender;
@end
