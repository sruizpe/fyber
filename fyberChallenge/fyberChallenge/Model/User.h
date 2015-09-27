//
//  User.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *userId;

- (instancetype)initWithUserId:(NSString *)userId;

@end
