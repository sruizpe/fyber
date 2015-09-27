//
//  OfferType.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferType : NSObject

@property (nonatomic, strong) NSNumber *offerTypeId;
@property (nonatomic, strong) NSString *offerTypeReadable;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
