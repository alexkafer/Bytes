//
//  ByteCounter.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "ByteCounter.h"

@implementation ByteCounter

+(int)amountOfBytesFromString:(NSString *) string {
    // Going with the standard of one byte per letter and space
    return string.length;
}

@end
