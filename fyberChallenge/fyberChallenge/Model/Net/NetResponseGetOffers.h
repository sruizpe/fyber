//
//  NetResponseGetOffers.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetResponseGetOffers : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *offers;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
