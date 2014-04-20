//
//  ByteCounter.m
//  Bytes
//
//  Created by Alex Kafer on 2/5/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKByteCounter.h"

@implementation AKByteCounter

+(int)bytesFromObject: (NSObject *)object {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:@"object"];
    NSData *dataOnObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"object"];
    
    return [dataOnObject length]-135; //An empty NSObject is 135 bytes in an NSData, trying to keep the data of just user input
}
@end
