//
//  AKData.h
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKData : NSObject

+(int)createCodeWithBytes:(int)bytes;
+(int)getBytesWithCode:(int)bytes;

@end
