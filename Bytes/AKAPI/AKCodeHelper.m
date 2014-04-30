//
//  AKCodeHelper.m
//  Bytes
//
//  Created by Alex Kafer on 4/24/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKCodeHelper.h"
#import "AKData.h"

@implementation AKCodeHelper

-(id)initWithBytes: (NSInteger) bytes shouldCreateCode: (BOOL)shouldCode {
    self = [super init];
    if (self){
        [self setBytes:bytes];
        if (shouldCode) {
            [self setCode:[AKData createCodeWithBytes:bytes]];
        } else {
            [self setCode:0];
        }
    }
    return self;
}

-(id)initWithCode:(NSInteger)code {
    self = [super init];
    if (self){
        [self setCode:code];
        [self setBytes:[AKData getBytesWithCode:code]];
    }
    return self;
}

@end
