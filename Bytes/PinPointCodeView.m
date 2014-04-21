//
//  PinPointCodeView.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "PinPointCodeView.h"
#import "AKStyler.h"

@implementation PinPointCodeView

-(id)initFromNib {
    if (self = [super initWithNibName:@"PinPointCodeView"])
    {
        
    }
    return self;
}

- (void)loadView
{
    [AKStyler styleLayer:self.layer opacity:0.3 fancy:YES];
    // Do any additional setup after loading the view from its nib.
}

@end
