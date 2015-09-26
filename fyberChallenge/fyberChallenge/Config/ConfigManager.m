//
//  ConfigManager.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "ConfigManager.h"

#define kConfigurationUrlAppGlobal              @"urlAppGlobal"
#define kConfigurationApplicationKey            @"applicationKey"
#define kConfigurationApplicationId             @"applicationId"
#define kConfigurationApplicationUserId         @"userId"

@interface ConfigManager ()

@property (nonatomic, strong) NSString *configuration;
@property (nonatomic, strong) NSDictionary *variables;

@end

@implementation ConfigManager

- (id)init
{
    if (self = [super init]) {
        // Fetch Current Configuration
        self.configuration = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];
        NSString *configFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Settings"];
        
        // Load Configurations
        NSString *path = [[NSBundle mainBundle] pathForResource:configFile ofType:@"plist"];
        NSDictionary *parameters = [NSDictionary dictionaryWithContentsOfFile:path];
        
        // Load Variables for Current Configuration
        self.variables = [parameters objectForKey:self.configuration];
    }
    return self;
}

#pragma mark - Class methods

+ (ConfigManager *)sharedManager
{
    static ConfigManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark - Public methods

- (void)setupDefaultConfiguration
{
    NSLog(@"\n\n\n\n CONFIGURATION MANAGER: \n%@\n\n\n\n", self.configuration);
    NSLog(@"\n\n\n\n CONFIGURATION MANAGER: \n%@\n\n\n\n", self.variables);
}

- (NSString *)urlAppGlobal
{
    if (self.variables) {
        return [self.variables objectForKey:kConfigurationUrlAppGlobal];
    }
    return nil;
}

- (NSString *)applicationKey
{
    if (self.variables) {
        return [self.variables objectForKey:kConfigurationApplicationKey];
    }
    return nil;
}

- (NSString *)applicationId
{
    if (self.variables) {
        return [self.variables objectForKey:kConfigurationApplicationId];
    }
    return nil;
}

- (NSString *)userId
{
    if (self.variables) {
        return [self.variables objectForKey:kConfigurationApplicationUserId];
    }
    return nil;
}

@end
