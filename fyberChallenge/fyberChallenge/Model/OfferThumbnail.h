//
//  OfferThumbnail.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferThumbnail : NSObject

@property (nonatomic, strong) NSString *offerThumbnailHires;
@property (nonatomic, strong) NSString *offerThumbnailLowres;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
