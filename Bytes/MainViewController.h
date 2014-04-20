//
//  MainViewController.h
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTapGestureRecognizer.h"

@interface MainViewController : UIViewController <UIScrollViewDelegate, CardTapGestureRecognizerDelegate> {
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UISegmentedControl *segControl;
    IBOutlet UIView *upperView;
    
    UIScrollView *bytesScroller;
    IBOutlet UIView *bytesSlider;
    
    CGPoint overlayCenter;
    BOOL extended;
    CGPoint currentExtendedPoint;
    
    UITouch *lastCardTouch;
    
    NSMutableArray *cardViewControllers;
}

-(IBAction)scrollWith:(id)sender;
@end
