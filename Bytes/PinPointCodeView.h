//
//  PinPointCodeView.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PinPointCodeView : CardView

@property (nonatomic, retain) IBOutlet UIButton *randomCode;
@property (nonatomic, retain) IBOutlet UILabel *codeField;
@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *useCodeBtn;

- (id)initWithPinPointTitle: (NSString *)string discription: (NSString *)description;

@end
