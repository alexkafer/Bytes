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

@implementation AuthView
@synthesize loginButton, cancelButton;

-(id)initFromNib {
    if (self = [super initWithNibName:@"AuthView"])
    {
         NSLog(@"Loaded Auth!");
    }
    return self;
}

-(void)loadView {
    [AKStyler styleLayer:loginButton.layer opacity:0.1 fancy:NO];
    [AKStyler styleLayer:cancelButton.layer opacity:0.1 fancy:NO];
     NSLog(@"Prettiezed Auth!");
    [AKStyler styleLayer:self.layer opacity:0.1 fancy:NO];
}

@end
