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

#pragma mark - Offers

- (void)getOffersWithCompletion:(ArrayCompletionBlock)completion;

#pragma mark - Images

- (void)getImageUrl:(NSString *)url completion:(ObjectCompletionBlock)completion;

@end
