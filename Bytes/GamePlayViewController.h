//
//  GamePlayViewController.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKGame.h"
#import "AKMenu.h"
#import "ObjectView.h"

#import "DBCameraViewController.h"
#import "DBCameraContainer.h"

#import "StartView.h"
#import "PauseView.h"

@protocol GamePlayViewControllerDelegate <NSObject>
-(void)addObjectView: (ObjectView *)view;
@end

@interface GamePlayViewController : UIViewController <AKMenuDelegate, DBCameraViewControllerDelegate, UIAlertViewDelegate, AKGameDelegate>
{
    

    int bytesLeft;
    NSMutableArray *currentlyActiveObjects;
    NSTimer *objectUpdater;
    
    StartView *startDialog;
    PauseView *pauseDialog;
}

@property (nonatomic, retain) IBOutlet UILabel *scoreView;
@property (nonatomic, retain) IBOutlet UIButton *addBtn;
@property (nonatomic, retain) IBOutlet UILabel *subLabel;
@property (nonatomic, retain) AKGame *currentGame;

@property (nonatomic, assign) id<GamePlayViewControllerDelegate> delegate;

@property (strong, nonatomic) AKMenu *mediaMenu;
- (IBAction)menuPressed:(id)sender;

@end
