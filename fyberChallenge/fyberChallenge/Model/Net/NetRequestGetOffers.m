//
//  NetRequestGetOffers.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "NetRequestGetOffers.h"
#import "CommonUtils.h"

#define kNetRequestGetOffersAppId                   @"appid"
#define kNetRequestGetOffersUID                     @"uid"
#define kNetRequestGetOffersLocale                  @"locale"
#define kNetRequestGetOffersOSVersion               @"os_version"
#define kNetRequestGetOffersTimestamp               @"timestamp"
#define kNetRequestGetOffersAppleIdfa               @"apple_idfa"
#define kNetRequestGetOffersAppleIdfaEnable         @"apple_idfa_tracking_enabled"
#define kNetRequestGetOffersHashKey                 @"hashkey"
#define kNetRequestGetOffersIp                      @"ip"
#define kNetRequestGetOffersType                    @"offer_types"

@implementation NetRequestGetOffers

- (NSArray *)queryItemsForAPIKey:(NSString *)apiKey
{
    NSDictionary *jsonDictionary = [self JSONKeyPathsByPropertyKeyForAPIKey:apiKey];
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in jsonDictionary) {
        NSString *value = [jsonDictionary objectForKey:key];
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:value]];
    }
    
    return queryItems;
}

- (NSDictionary *)JSONKeyPathsByPropertyKeyForAPIKey:(NSString *)apiKey
{
    // build dictionary
    NSMutableDictionary *paramsDictionary = [[NSMutableDictionary alloc] init];
    [paramsDictionary setObject:self.appid forKey:kNetRequestGetOffersAppId];
    [paramsDictionary setObject:self.uid forKey:kNetRequestGetOffersUID];
    [paramsDictionary setObject:self.locale forKey:kNetRequestGetOffersLocale];
    [paramsDictionary setObject:self.osVersion forKey:kNetRequestGetOffersOSVersion];
    [paramsDictionary setObject:self.timestamp forKey:kNetRequestGetOffersTimestamp];
    [paramsDictionary setObject:self.appleIdfa forKey:kNetRequestGetOffersAppleIdfa];
    [paramsDictionary setObject:(self.appleIdfaTrackingEnabled ? @"true" : @"false") forKey:kNetRequestGetOffersAppleIdfaEnable];
    [paramsDictionary setObject:self.ip forKey:kNetRequestGetOffersIp];
    [paramsDictionary setObject:self.offerTypes forKey:kNetRequestGetOffersType];
    
    // hashkey calculation
    NSArray *sortedKeys = [[paramsDictionary allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    NSString *noHashKey = @"";
    for (NSString *key in sortedKeys)
    {
        NSString *keyAndValue = [NSString stringWithFormat:@"%@=%@&", key, [paramsDictionary objectForKey:key]];
        noHashKey = [noHashKey stringByAppendingString:keyAndValue];
    }
    noHashKey = [noHashKey stringByAppendingString:apiKey];
    
    if ([noHashKey isEqualToString:apiKey])
        return nil;
    
    // hashkey encoding
    NSString *hashKey = [CommonUtils SHA1Encryption:noHashKey lowerCase:YES];
    
    // add hash key
    [paramsDictionary setObject:hashKey forKey:kNetRequestGetOffersHashKey];
    
    return paramsDictionary;
}

@end
