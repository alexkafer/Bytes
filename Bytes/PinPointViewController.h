//
//  PinPointViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayViewController.h"

@interface PinPointViewController : GamePlayViewController <GamePlayViewControllerDelegate> {
    int bytesLeft;
}

@property (nonatomic) NSInteger *targetGoal;

@end
