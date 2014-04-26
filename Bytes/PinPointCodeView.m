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

@synthesize randomCode, codeField, useCodeBtn, makeCode;

-(id)initWithPinPointTitle: (NSString *)stringTitle discription: (NSString *)stringDescription {
    if (self = [super initWithNibName:@"PinPointCodeView"])
    {
        title = stringTitle;
        description = stringDescription;
        codeHelper = nil;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.titleLabel.text = title;
    self.descriptionLabel.text = description;

    [AKStyler styleLayer:useCodeBtn.layer opacity:0.2 fancy:NO];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - Byte Goal Methods

-(void) setBytesTo: (NSInteger)bytes {
    codeHelper = nil;
    NSLog(@"%hhd", makeCode.on);
    codeHelper = [[AKCodeHelper alloc] initWithBytes:bytes shouldCreateCode:makeCode.on];
    
    [[self randomCode] setTitle:[NSString stringWithFormat:@"%d", [codeHelper bytes]] forState:UIControlStateNormal];
    
    if ([codeHelper code] > 0) {
        [[self codeField] setText:[NSString stringWithFormat:@"%d", [codeHelper code]]];
        [[self codeField] setHidden:NO];
    } else {
        [[self codeField] setText:@""];
    }
}
-(void) setCodeTo: (NSInteger)code {
    codeHelper = nil;
    codeHelper = [[AKCodeHelper alloc] initWithCode:code];
    NSLog(@"Code: %d, Bytes: %d", [codeHelper code], [codeHelper bytes]);
    [[self codeField] setText:[NSString stringWithFormat:@"%d", [codeHelper code]]];
    [[self randomCode] setTitle:[NSString stringWithFormat:@"%d", [codeHelper bytes]] forState:UIControlStateNormal];
    [[self codeField] setHidden:NO];
}

-(NSInteger)getBytesForGame {
    return [codeHelper bytes];
}

@end
