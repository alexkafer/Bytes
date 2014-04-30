//
//  UIView+InitNib.m
//  Bytes
//
//  Created by Alex Kafer on 4/12/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "UIView+InitNib.h"

@implementation UIView (InitNib)

- (instancetype)initWithNibName:(NSString *)nibName
{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    if (arrayOfViews.count < 1) {
        return nil;
    }
    
    self = arrayOfViews[0];
    
    return self;
}

@end
