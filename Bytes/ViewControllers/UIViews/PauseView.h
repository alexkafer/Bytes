//
//  PauseView.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PauseView : UIView

@property(nonatomic, retain) IBOutlet UIButton *endGame;
@property(nonatomic, retain) IBOutlet UIButton *returnToGame;

-(id)initFromNibPause;
-(void)loadView;

@end
