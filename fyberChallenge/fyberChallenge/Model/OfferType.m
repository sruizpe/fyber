//
//  OfferType.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "OfferType.h"

#define kOfferTypeJSONKeyPathId                 @"offer_type_id"
#define kOfferTypeJSONKeyPathReadable           @"readable"

@implementation OfferType

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _offerTypeId = [dictionary objectForKey:kOfferTypeJSONKeyPathId];
        _offerTypeReadable = [dictionary objectForKey:kOfferTypeJSONKeyPathReadable];
    }
    return self;
}

@end
