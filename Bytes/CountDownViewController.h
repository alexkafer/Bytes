//
//  CountDownViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/16/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayViewController.h"

@interface CountDownViewController : GamePlayViewController <GamePlayViewControllerDelegate> {
    int totalBytes;
    int seconds;
}

@end
