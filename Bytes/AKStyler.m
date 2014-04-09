//
//  AKStyler.m
//  Bytes
//
//  Created by Alex Kafer on 4/7/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKStyler.h"

@implementation AKStyler

+ (CGPathRef)fancyShadowForRect:(CGRect)rect distance:(float)distance {
    CGSize size = rect.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    //right
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(size.width, 0.0f)];
    [path addLineToPoint:CGPointMake(size.width, size.height + distance)];
    
    //curved bottom
    [path addCurveToPoint:CGPointMake(0.0, size.height + distance)
            controlPoint1:CGPointMake(size.width - distance, size.height)
            controlPoint2:CGPointMake(distance, size.height)];
    
    [path closePath];
    
    return path.CGPath;
}

+ (void)styleLayer:(CALayer *)layer opacity:(float)opacity fancy: (BOOL)fancy {
    layer.cornerRadius = 4.0f;
    layer.shadowOffset =  CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = opacity;
    
    if(fancy) {
        layer.shadowPath = [AKStyler fancyShadowForRect:layer.bounds distance:15.0f];
    }else {
        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    }
    
}

@end
