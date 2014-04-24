//
//  PinPointCodeView.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "PinPointCodeView.h"
#import "UIView+InitNib.h"
#import "AKStyler.h"

@interface PinPointCodeView ()
{
    NSString *title;
    NSString *description;
}

@end

@implementation PinPointCodeView

@synthesize randomCode, codeField, clearButton, useCodeBtn;

-(id)initWithPinPointTitle: (NSString *)stringTitle discription: (NSString *)stringDescription {
    if (self = [super initWithNibName:@"PinPointCodeView"])
    {
        title = stringTitle;
        description = stringDescription;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;

    [AKStyler styleLayer:useCodeBtn.layer opacity:0.2 fancy:NO];
    [AKStyler styleLayer:clearButton.layer opacity:0.2 fancy:NO];
    // Do any additional setup after loading the view from its nib.
}

@end
