//
//  AuthViewController.m
//  Bytes
//
//  Created by Alex Kafer on 4/8/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AuthView.h"
#import "AKStyler.h"
#import "UIView+InitNib.h"
#import "UIView+draggable.h"

@implementation AuthView
@synthesize loginButton, cancelButton;

-(id)initFromNib {
    if (self = [super initWithNibName:@"AuthView"])
    {
    }
    return self;
}

-(void)loadView {
    [AKStyler styleLayer:loginButton.layer opacity:0.1 fancy:NO];
    [AKStyler styleLayer:cancelButton.layer opacity:0.1 fancy:NO];
    [AKStyler styleLayer:self.layer opacity:0.1 fancy:NO];
}

-(void)startDragging {
    [self enableDragging];
    [self setDraggable:YES];
}

-(void)lockDragging: (BOOL) lock {
    [self setDraggable:!lock];
}

@end
