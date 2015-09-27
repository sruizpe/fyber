//
//  NetworkHelper.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigManager.h"
#import "Blocks.h"
#import "Offer.h"

@interface NetworkHelper : NSObject

+ (NetworkHelper *)sharedManager;

- (void)getOffersWithCompletion:(ArrayCompletionBlock)completion;

@end
