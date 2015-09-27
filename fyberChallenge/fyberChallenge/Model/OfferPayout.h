//
//  OfferPayout.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferPayout : NSObject

@property (nonatomic, strong) NSNumber *offerPayoutAmount;
@property (nonatomic, strong) NSString *offerPayoutAmountReadable;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
