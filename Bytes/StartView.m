//
//  StartView.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "StartView.h"
#import "UIView+InitNib.h"

#import "AKStyler.h"

@implementation StartView

-(id)initFromNibStart {
    self = [super initWithNibName:@"StartView"];
    if (self) {
        
    }
    return self;
}

-(void)loadView {
    [AKStyler styleLayer:[self.startGame layer] opacity:0.0 fancy:NO];
    [AKStyler styleLayer:[self layer] opacity:0.3 fancy:NO];
}

@end
