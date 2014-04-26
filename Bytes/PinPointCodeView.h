//
//  PinPointCodeView.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKCodeHelper.h"
#import "CardView.h"

@interface PinPointCodeView : CardView {
    AKCodeHelper *codeHelper;
}

@property (nonatomic, retain) IBOutlet UIButton *randomCode;
@property (nonatomic, retain) IBOutlet UILabel *codeField;
@property (nonatomic, retain) IBOutlet UIButton *useCodeBtn;
@property (nonatomic, retain) IBOutlet UISwitch *makeCode;

- (id)initWithPinPointTitle: (NSString *)string discription: (NSString *)description;

-(void) setBytesTo: (NSInteger)bytes;
-(void) setCodeTo: (NSInteger)code;
-(NSInteger) getBytesForGame;

@end