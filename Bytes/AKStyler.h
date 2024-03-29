//
//  AKStyler.h
//  Bytes
//
//  Created by Alex Kafer on 4/7/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKStyler : NSObject

+ (CGPathRef)fancyShadowForRect:(CGRect)rect distance:(float)distance;
+ (void)styleLayer:(CALayer *)layer opacity:(float)opacity fancy: (BOOL)fancy;
+ (CGPathRef)cardShadowForRect:(CGRect)rect distance:(float)distance;
+ (UIImage*)circularScaleAndCropImage:(UIImage*)image frame:(CGRect)frame;

+(NSURL *)getGravatarURL:(NSString *)emailAddress withSize: (int)pixelSize;

@end
