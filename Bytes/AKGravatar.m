//
//  AKGravatar.m
//  Bytes
//
//  Created by Alex Kafer on 4/9/14.
//  Copyright (c) 2014 Kintas. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "AKGravatar.h"

@implementation AKGravatar

+(NSURL *)getGravatarURL:(NSString *)emailAddress withSize: (int)pixelSize{
    NSString *curatedEmail = [[emailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lowercaseString];
    const char *cStr = [curatedEmail UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // cumpute the MD5 gravatar requires
    
    NSString *md5email = [NSString stringWithFormat:
                          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          result[0], result[1], result[2], result[3],
                          result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11],
                          result[12], result[13], result[14], result[15]
                          ];
    
    NSString *gravatarEndPoint = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=%d", md5email, pixelSize];
    
	return [NSURL URLWithString:gravatarEndPoint];
}

@end
