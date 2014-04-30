//
//  PauseView.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "PauseView.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@implementation PauseView

-(id)initFromNibPause {
    self = [super initWithNibName:@"PauseView"];
    if (self) {
        
    }
    return self;
}

-(void)loadView {
    [AKStyler styleLayer:[self.endGame layer] opacity:0.0 fancy:NO];
    [AKStyler styleLayer:[self.returnToGame layer] opacity:0.0 fancy:NO];
    [AKStyler styleLayer:[self layer] opacity:0.3 fancy:NO];
}

@end
