//
//  User.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

@end
