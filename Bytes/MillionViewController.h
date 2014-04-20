//
//  MillionViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayViewController.h"

@interface MillionViewController : GamePlayViewController <GamePlayViewControllerDelegate> {
    int totalBytes;
}

@end
