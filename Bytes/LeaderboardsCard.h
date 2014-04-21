//
//  BytesCard.h
//  Bytes
//
//  Created by Alex Kafer on 4/15/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface LeaderboardsCard : UIView

@property (nonatomic, retain) CardView *replacedCard;

-(id)initFromNib;
- (void)loadView;

@end
