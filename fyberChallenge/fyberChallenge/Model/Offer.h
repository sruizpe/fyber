//
//  Offer.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferType.h"
#import "OfferThumbnail.h"
#import "OfferPayout.h"

@interface Offer : NSObject

@property (nonatomic, strong) NSNumber *offerId;
@property (nonatomic, strong) NSString *offerTitle;
@property (nonatomic, strong) NSString *offerLink;
@property (nonatomic, strong) NSString *offerPayout;
@property (nonatomic, strong) NSString *offerRequiredActions;
@property (nonatomic, strong) NSString *offerStoreId;
@property (nonatomic, strong) NSString *offerTeaser;
@property (nonatomic, strong) NSArray *offerTypes;
@property (nonatomic, strong) OfferThumbnail *offerThumbnail;
@property (nonatomic, strong) OfferPayout *offerPayoutTime;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
