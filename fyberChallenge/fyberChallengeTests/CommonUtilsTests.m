//
//  CommonUtilsTests.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 28/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CommonUtils.h"

@interface CommonUtilsTests : XCTestCase

@end

@implementation CommonUtilsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testThatItCheckEmptyStringHashing
{
    NSString *stringHash = [CommonUtils SHA1Encryption:nil lowerCase:NO];
    XCTAssertNil(stringHash, @"SHA1 encryption over a empty string fails");
}

- (void)testThatItCheckUppercaseStringHashing
{
    NSString *stringHash = [CommonUtils SHA1Encryption:@"Test" lowerCase:YES];
    XCTAssertEqualObjects(@"640ab2bae07bedc4c163f679a746f7ab7fb5d1fa", stringHash, @"SHA1 encryption over uppercase string fails");
}

- (void)testThatItCheckLowercaseStringHashing
{
    NSString *stringHash = [CommonUtils SHA1Encryption:@"Test" lowerCase:NO];
    XCTAssertEqualObjects(@"640AB2BAE07BEDC4C163F679A746F7AB7FB5D1FA", stringHash, @"SHA1 encryption over lowercase string fails");
}

@end
