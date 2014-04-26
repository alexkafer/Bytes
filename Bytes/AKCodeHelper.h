//
//  AKCodeHelper.h
//  Bytes
//
//  Created by Alex Kafer on 4/24/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKCodeHelper : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic) NSInteger bytes;

-(id)initWithBytes: (NSInteger) bytes shouldCreateCode: (BOOL)shouldCode;
-(id)initWithCode: (NSInteger) code;

@end
