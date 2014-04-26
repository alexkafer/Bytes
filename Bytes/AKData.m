//
//  AKData.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKData.h"

@implementation AKData

+(int)getBytesWithCode:(NSInteger)code {
    NSString *url = [NSString stringWithFormat:@"%@%ld", @"http://kintas.com/bytes/bytes.php?code=", (long)code];
    NSLog(@"URL: %@", url);
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSDictionary *results = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    if ([[results objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
        return 0;
    }
    
    NSInteger bytesFromCode = [[results objectForKey:@"result"] integerValue];
    return bytesFromCode;
}

+(int)createCodeWithBytes:(NSInteger)bytes {
    NSString *url = [NSString stringWithFormat:@"%@%ld", @"http://kintas.com/bytes/bytes.php?bytes=", (long)bytes];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSDictionary *results = [NSJSONSerialization
                             JSONObjectWithData:jsonData
                             options:0
                             error:&error];
    
    if ([[results objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
        return 0;
    }
    
    NSInteger codeFromBytes = [[results objectForKey:@"result"] integerValue];
    return codeFromBytes;
}

@end
