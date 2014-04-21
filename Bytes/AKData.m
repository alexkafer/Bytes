//
//  AKData.m
//  Bytes
//
//  Created by Alex Kafer on 4/20/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//

#import "AKData.h"

@implementation AKData

+(int)getBytesWithCode:(int)code {
    NSString *url = [NSString stringWithFormat:@"%@%d", @"http://kintas.com/bytes/bytes.php?code=", code];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSDictionary *results = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    
    return (int)[results objectForKey:@"result"];
}

+(int)createCodeWithBytes:(int)bytes {
    NSString *url = [NSString stringWithFormat:@"%@%d", @"http://kintas.com/bytes/bytes.php?bytes=", bytes];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSDictionary *results = [NSJSONSerialization
                             JSONObjectWithData:jsonData
                             options:0
                             error:&error];
    
    return (int)[results objectForKey:@"result"];
}

@end
