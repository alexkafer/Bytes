//
//  CardViewController.m
//  LifeWorksTurck
//
//  Created by Alex Kafer on 3/23/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "CardView.h"
#import "AKStyler.h"
#import "UIView+InitNib.h"
#import <QuartzCore/QuartzCore.h>

@interface CardView ()
{
    NSString *title;
    NSString *description;
}

@end

@implementation CardView
@synthesize titleLabel, descriptionLabel, button, gamePlayControllerIdentifier;

-(id)initWithTitle: (NSString *)stringTitle discription: (NSString *)stringDescription {
    if (self = [super initWithNibName:@"CardView"])
    {
        title = stringTitle;
        description = stringDescription;
    }
    return self;
}

- (void)loadView
{
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;
    [AKStyler styleLayer:self.layer opacity:0.3 fancy:YES];
    [AKStyler styleLayer:button.layer opacity:0.2 fancy:NO];
    // Do any additional setup after loading the view from its nib.
}

@end
