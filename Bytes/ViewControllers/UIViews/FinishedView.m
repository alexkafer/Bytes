//
//  FinishedView.m
//  Bytes
//
//  Created by Alex Kafer on 4/26/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "FinishedView.h"
#import "UIView+InitNib.h"

#import "AKStyler.h"

@implementation FinishedView
@synthesize scoreLabel, menu, replay, leaderboards;

-(id)initWithScore: (float)score andTerm: (NSString *)term {
    self = [super initWithNibName:@"FinishedView"];
    if (self) {
        endScore = score;
        typeTerm = term;
    }
    return self;
}

-(void)loadView {
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d %@", (int)endScore, typeTerm]];
    
    [AKStyler styleLayer:[self.menu layer] opacity:0.0 fancy:NO];
    [AKStyler styleLayer:[self.replay layer] opacity:0.0 fancy:NO];
    [AKStyler styleLayer:[self.leaderboards layer] opacity:0.0 fancy:NO];
    [AKStyler styleLayer:[self layer] opacity:0.3 fancy:NO];
}


@end
