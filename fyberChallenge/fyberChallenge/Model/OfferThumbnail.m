//
//  OfferThumbnail.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "OfferThumbnail.h"

#define kOfferThumbnailJSONKeyPathHires                 @"hires"
#define kOfferThumbnailJSONKeyPathLowres                @"lowres"

@implementation OfferThumbnail

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _offerThumbnailHires = [dictionary objectForKey:kOfferThumbnailJSONKeyPathHires];
        _offerThumbnailLowres = [dictionary objectForKey:kOfferThumbnailJSONKeyPathLowres];
    }
    return self;
}

@end
