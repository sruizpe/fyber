//
//  ConfigManager.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject

+ (ConfigManager *)sharedManager;

#pragma mark - Public methods

- (void)setupDefaultConfiguration;
- (NSString *)urlAppGlobal;
- (NSString *)applicationKey;
- (NSString *)applicationId;
- (NSString *)userId;

@end
