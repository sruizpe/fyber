//
//  NetResponseGetOffers.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "NetResponseGetOffers.h"
#import "Offer.h"

#define kNetResponseGetOffersCode                   @"code"
#define kNetResponseGetOffersMessage                @"message"
#define kNetResponseGetOffersOffers                 @"offers"

@implementation NetResponseGetOffers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        NSDictionary *offersDictionary = [dictionary objectForKey:kNetResponseGetOffersOffers];
        
        NSMutableArray *offers;
        for (NSDictionary *offerDictionary in offersDictionary)
        {
            if (!offers)
                offers = [NSMutableArray array];
            
            Offer *offer = [[Offer alloc] initWithDictionary:offerDictionary];
            [offers addObject:offer];
        }
        _offers = offers;
        _code = [dictionary objectForKey:kNetResponseGetOffersCode];
        _message = [dictionary objectForKey:kNetResponseGetOffersMessage];
    }
    return self;
}

@end
