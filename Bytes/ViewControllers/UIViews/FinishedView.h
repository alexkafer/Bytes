//
//  FinishedView.h
//  Bytes
//
//  Created by Alex Kafer on 4/26/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishedView : UIView {
    NSString *typeTerm;
    float endScore;
}

@property(nonatomic, retain) IBOutlet UIButton *menu;
@property(nonatomic, retain) IBOutlet UIButton *replay;
@property(nonatomic, retain) IBOutlet UIButton *leaderboards;

@property(nonatomic, retain) IBOutlet UILabel *scoreLabel;
-(id)initWithScore: (float)score andTerm: (NSString *)term;
-(void)loadView;

@end
