//
//  BytesOverlay.m
//  Bytes
//
//  Created by Alex Kafer on 4/19/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "BytesOverlay.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@implementation BytesOverlay

- (id) initFromNib {
    self = [super initWithNibName:@"BytesOverlayView"];
    if (self) {
        
    }
    return self;
}

-(void)loadView {
    tabView.layer.cornerRadius = 4;
    [AKStyler styleLayer:tabView.layer opacity:0.3 fancy:NO];
    [AKStyler styleLayer:bodyContent.layer opacity:0.3 fancy:NO];
}

@end
