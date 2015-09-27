//
//  CommonUtils.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "CommonUtils.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation CommonUtils

+ (NSString *)SHA1Encryption:(NSString *)string
{
    if (!string)
        return nil;
    
    const char *str = [string UTF8String];
    NSData *data = [NSData dataWithBytes:str length:[string length]];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
