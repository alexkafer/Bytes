//
//  StartView.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartView : UIView

@property(nonatomic, retain) IBOutlet UIButton *startGame;


-(id)initFromNibStart;
-(void)loadView;


@end
