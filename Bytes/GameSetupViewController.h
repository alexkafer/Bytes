//
//  GameSetupViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameSetupPlayerView.h"
#import "AKGame.h"

@interface GameSetupViewController : UIViewController {
    AKGame *currentGame;
    
    NSMutableArray *players;
    BOOL isAdding;
}


@end
