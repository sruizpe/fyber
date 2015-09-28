//
//  NetworkHelperTests.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 28/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkHelper.h"

@interface NetworkHelperTests : XCTestCase

@end

@implementation NetworkHelperTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testThatItCheckAsyncGetOffers
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test asyncronous method"];
    [[NetworkHelper sharedManager] getOffersWithCompletion:^(NSArray *array, NSError *error) {
        XCTAssertNil(error, @"Asyncronous request to get offers returns an error");
        XCTAssertNotNil(array, @"Asyncronous request to get offers returns empty array");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"Asyncronous request to get offers returns an error");
    }];
    
}

- (void)testThatItCheckAsyncGetImage
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test asyncronous method"];
    [[NetworkHelper sharedManager] getImageUrl:@"http://cdn3.sponsorpay.com/assets/49592/iphone6_square_60.png" completion:^(id object, NSError *error) {
        XCTAssertNil(error, @"Asyncronous request to get an image returns an error");
        XCTAssertNotNil(object, @"Asyncronous request to get offers returns empty object");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"Asyncronous request to get an image returns an error");
    }];
    
}

@end
