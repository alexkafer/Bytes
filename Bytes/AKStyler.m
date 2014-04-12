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

+ (CGPathRef)cardShadowForRect:(CGRect)rect distance:(float)distance {
    CGSize size = rect.size;
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    //right
    [path moveToPoint:CGPointMake(size.width-320, 0)];
    [path addLineToPoint:CGPointMake(320.0f, 0.0f)];
    [path addLineToPoint:CGPointMake(320.0f, distance)];
    [path addLineToPoint:CGPointMake(size.width, distance)];
    [path addLineToPoint:CGPointMake(size.width, size.height + distance)];
    
    //curved bottom
    [path addCurveToPoint:CGPointMake(0.0, size.height + distance)
            controlPoint1:CGPointMake(size.width - distance, size.height)
            controlPoint2:CGPointMake(distance, size.height)];
    
    [path addLineToPoint:CGPointMake(0.0, distance)];
    [path addLineToPoint:CGPointMake(size.width-320, distance)];
    
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

#include <math.h>

+ (UIImage*)circularScaleAndCropImage:(UIImage*)image frame:(CGRect)frame {
    // This function returns a newImage, based on image, that has been:
    // - scaled to fit in (CGRect) rect
    // - and cropped within a circle of radius: rectWidth/2
    
    //Create the bitmap graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(frame.size.width, frame.size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Get the width and heights
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat rectWidth = frame.size.width;
    CGFloat rectHeight = frame.size.height;
    
    //Calculate the scale factor
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    
    //Calculate the centre of the circle
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
    
    // Create and CLIP to a CIRCULAR Path
    // (This could be replaced with any closed path if you want a different shaped clip)
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    
    //Set the SCALE factor for the graphics context
    //All future draw calls will be scaled by this factor
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    
    // Draw the IMAGE
    CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
    [image drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
