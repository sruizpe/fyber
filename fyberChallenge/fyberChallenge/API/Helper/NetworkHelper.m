//
//  NetworkHelper.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "NetworkHelper.h"
#import "User.h"
#import "Constants.h"
#import "NetRequestGetOffers.h"
#import "NetResponseGetOffers.h"
#import <AdSupport/ASIdentifierManager.h>
#import "CommonUtils.h"

#define kNetworkHelperHTTPHeaderKeyPathSignature    @"X-Sponsorpay-Response-Signature"

@interface NetworkHelper()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSString *baseUrl;

@property (nonatomic, strong) NSString *applicationKey;
@property (nonatomic, strong) NSString *applicationId;
@property (nonatomic, strong) User *currentUser;

@property (nonatomic, strong) NSError *errorSignature;

@end

@implementation NetworkHelper

- (id)init
{
    if (self = [super init])
    {
        // init network configuration
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 30.0;
        config.timeoutIntervalForResource = 30.0;
        config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        [config setHTTPAdditionalHeaders:@{@"Accept": @"application/json"}];
        
        // init network session
        _urlSession = [NSURLSession sessionWithConfiguration:config];
        _baseUrl = [[ConfigManager sharedManager] urlAppGlobal];
        
        // init network params
        _applicationKey = [[ConfigManager sharedManager] applicationKey];;
        _applicationId = [[ConfigManager sharedManager] applicationId];
        _currentUser = [[User alloc] initWithUserId:[[ConfigManager sharedManager] userId]];
        
        // init signature error
        _errorSignature = [NSError errorWithDomain:@"Fyber" code:0 userInfo:[NSDictionary dictionaryWithObject:@"Invalid response signature" forKey:NSLocalizedDescriptionKey]];
    }
    return self;
}


#pragma mark - Class methods

+ (NetworkHelper *)sharedManager
{
    static NetworkHelper *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


#pragma mark - Public methods

- (BOOL)isSignatureValid:(NSString *)signature forResponse:(NSString *)response
{
    if (!signature)
        return NO;

    NSString *composeString = [response stringByAppendingString:self.applicationKey];
    NSString *composeHashString = [CommonUtils SHA1Encryption:composeString lowerCase:YES];
    
    
    if (![signature isEqualToString:composeHashString]) {
        NSLog(@"RESPONSE %@", response);
        NSLog(@"COMPOSE_STRING %@", composeString);
        NSLog(@"COMPOSE_HASH %@", composeHashString);
        NSLog(@"SIGNATURE %@", signature);
        NSLog(@"EQUALS? %d", [signature isEqualToString:composeHashString]);
    }

    
    
    return [signature isEqualToString:composeHashString];
}

#pragma mark - Offers

- (void)getOffersWithCompletion:(ArrayCompletionBlock)completion
{
    NetRequestGetOffers *netRequestGetOffers = [[NetRequestGetOffers alloc] init];
    netRequestGetOffers.appid = self.applicationId;
    netRequestGetOffers.uid = [self.currentUser userId];
    netRequestGetOffers.locale = @"de"; //[[NSLocale preferredLanguages] firstObject];
    netRequestGetOffers.osVersion = [[UIDevice currentDevice] systemVersion];
    netRequestGetOffers.timestamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    netRequestGetOffers.appleIdfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    netRequestGetOffers.appleIdfaTrackingEnabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    netRequestGetOffers.ip = @"109.235.143.113";
    netRequestGetOffers.offerTypes = @"112";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.baseUrl , URL_OFFERS];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:urlString];
    urlComponents.queryItems = [netRequestGetOffers queryItemsForAPIKey:self.applicationKey];
    
    [[_urlSession dataTaskWithURL:urlComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (!error)
        {
            // validate response signature
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSDictionary *headersDictionary = [httpResponse allHeaderFields];
            NSString *signature = (headersDictionary) ? [headersDictionary objectForKey:kNetworkHelperHTTPHeaderKeyPathSignature] : nil;
            
            NSString *bodyResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if (![self isSignatureValid:signature forResponse:bodyResponse]) {
                if (completion) completion (nil, self.errorSignature);
                return;
            }
            
            // parse response
            NSError *parsingError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parsingError];
            
            if (!parsingError)
            {
                NetResponseGetOffers *netResponseGetOffers = [[NetResponseGetOffers alloc] initWithDictionary:responseDictionary];
                
                if ([netResponseGetOffers.code isEqualToString:@"OK"]) {
                    if (completion) completion (netResponseGetOffers.offers, nil);
                    return;
                }
                NSError *serverError = [NSError errorWithDomain:@"Fyber" code:0 userInfo:[NSDictionary dictionaryWithObject:netResponseGetOffers.message forKey:NSLocalizedDescriptionKey]];
                if (completion) completion (nil, serverError);
                return;
            }
            if (completion) completion (nil, parsingError);
            return;
        }
        if (completion) completion (nil, error);
    }] resume];
}


#pragma mark - Images

- (void)getImageUrl:(NSString *)url completion:(ObjectCompletionBlock)completion
{
    [[_urlSession downloadTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (!error)
        {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            if (completion) completion (downloadedImage, nil);
            return;
        }
        if (completion) completion (nil, error);
    }] resume];
}

@end
