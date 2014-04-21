//
//  BytesCard.m
//  Bytes
//
//  Created by Alex Kafer on 4/15/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "LeaderboardsCard.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@implementation LeaderboardsCard
@synthesize replacedCard;

-(id)initFromNib {
    if (self = [super initWithNibName:@"LeaderboardsCardView"])
    {
        
    }
    return self;
}

-(void)loadView {
    [AKStyler styleLayer:self.layer opacity:0.3 fancy:YES];
}

@end
