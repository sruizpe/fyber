//
//  Offer.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "Offer.h"

#define kOfferJSONKeyPathId                 @"offer_id"
#define kOfferJSONKeyPathTitle              @"title"
#define kOfferJSONKeyPathLink               @"link"
#define kOfferJSONKeyPathTypes              @"offer_types"
#define kOfferJSONKeyPathPayout             @"payout"
#define kOfferJSONKeyPathRequiredActions    @"required_actions"
#define kOfferJSONKeyPathStoreId            @"store_id"
#define kOfferJSONKeyPathTeaser             @"teaser"
#define kOfferJSONKeyPathThumbnail          @"thumbnail"
#define kOfferJSONKeyPathPayoutTime         @"time_to_payout"

@implementation Offer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _offerId = [dictionary objectForKey:kOfferJSONKeyPathId];
        _offerTitle = [dictionary objectForKey:kOfferJSONKeyPathTitle];
        _offerLink = [dictionary objectForKey:kOfferJSONKeyPathLink];
        _offerPayout = [dictionary objectForKey:kOfferJSONKeyPathPayout];
        _offerRequiredActions = [dictionary objectForKey:kOfferJSONKeyPathRequiredActions];
        _offerStoreId = [dictionary objectForKey:kOfferJSONKeyPathStoreId];
        _offerTeaser = [dictionary objectForKey:kOfferJSONKeyPathTeaser];
        
        NSDictionary *offerThumbnail = [dictionary objectForKey:kOfferJSONKeyPathThumbnail];
        if (offerThumbnail)
            _offerThumbnail = [[OfferThumbnail alloc] initWithDictionary:offerThumbnail];

        NSDictionary *offerPayoutTime = [dictionary objectForKey:kOfferJSONKeyPathPayoutTime];
        if (offerPayoutTime)
            _offerPayoutTime = [[OfferPayout alloc] initWithDictionary:offerPayoutTime];
        
        NSArray *offerTypesDictionaries = [dictionary objectForKey:kOfferJSONKeyPathTypes];
        NSMutableArray *offerTypesArray;
        for (NSDictionary *offerTypeDictionary in offerTypesDictionaries) {
            if (!offerTypesArray)
                offerTypesArray = [NSMutableArray array];
            
            OfferType *offerType = [[OfferType alloc] initWithDictionary:offerTypeDictionary];
            [offerTypesArray addObject:offerType];
        }
        _offerTypes = offerTypesArray;
    }
    return self;
}

@end
