//
//  NetRequestGetOffers.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestGetOffers : NSObject

@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *osVersion;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *hashkey;
@property (nonatomic, strong) NSString *appleIdfa;
@property (nonatomic, assign) BOOL appleIdfaTrackingEnabled;

- (NSArray *)queryItemsForAPIKey:(NSString *)apiKey;

@end
