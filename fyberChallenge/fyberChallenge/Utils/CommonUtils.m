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

+ (NSString *)SHA1Encryption:(NSString *)string lowerCase:(BOOL)lowerCase
{
    if (!string || [string length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    if (CC_SHA1([stringBytes bytes], (CC_LONG)[stringBytes length], digest))
    {
        NSMutableString *hexDigest = [NSMutableString stringWithCapacity:10];
        NSString *formatString = lowerCase ? @"%02x" : @"%02X";

        for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
            [hexDigest appendString:[NSString stringWithFormat:formatString, digest[i]]];
        return hexDigest;
    }
    return nil;
}

@end
