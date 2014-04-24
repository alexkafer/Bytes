//
//  PinEnterView.m
//  Bytes
//
//  Created by Alex Kafer on 4/24/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "PinEnterView.h"
#import "AKStyler.h"
#import "UIView+InitNib.h"

@implementation PinEnterView
@synthesize submitCode, cancelCode, codeFielder;

-(id)initFromNib {
    if (self = [super initWithNibName:@"PinEnterView"])
    {
        
    }
    return self;
}

- (void)loadView
{
    [AKStyler styleLayer:self.layer opacity:0.3 fancy:YES];
    [AKStyler styleLayer:submitCode.layer opacity:0 fancy:NO];
    [AKStyler styleLayer:cancelCode.layer opacity:0 fancy:NO];
    [AKStyler styleLayer:codeFielder.layer opacity:0.3 fancy:NO];
    // Do any additional setup after loading the view from its nib.
}

@end
