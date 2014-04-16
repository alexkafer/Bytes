//
//  BytesCard.m
//  Bytes
//
//  Created by Alex Kafer on 4/15/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "BytesCard.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@implementation BytesCard
@synthesize replacedCard;

-(id)initFromNib {
    if (self = [super initWithNibName:@"BytesCardView"])
    {
        
    }
    return self;
}

-(void)loadView {
    [AKStyler styleLayer:self.layer opacity:0.3 fancy:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
