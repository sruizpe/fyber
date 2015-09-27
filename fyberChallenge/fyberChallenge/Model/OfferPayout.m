//
//  OfferPayout.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "OfferPayout.h"

#define kOfferPayoutJSONKeyPathAmount                 @"amount"
#define kOfferPayoutJSONKeyPathAmountReadable         @"readable"

@implementation OfferPayout

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _offerPayoutAmount = [dictionary objectForKey:kOfferPayoutJSONKeyPathAmount];
        _offerPayoutAmountReadable = [dictionary objectForKey:kOfferPayoutJSONKeyPathAmountReadable];
    }
    return self;
}

@end
