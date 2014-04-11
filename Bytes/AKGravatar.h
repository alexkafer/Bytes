//
//  AKGravatar.h
//  Bytes
//
//  Created by Alex Kafer on 4/9/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKGravatar : NSObject

+(NSURL *)getGravatarURL:(NSString *)emailAddress withSize: (int)pixelSize;
+ (UIImage*)circularScaleAndCropImage:(UIImage*)image frame:(CGRect)frame;
@end
