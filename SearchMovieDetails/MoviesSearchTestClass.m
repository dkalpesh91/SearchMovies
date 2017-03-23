//
//  MoviesSearchTestClass.m
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 23/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MoviesSearchVC.h"

@interface MoviesSearchTestClass : XCTestCase

@property (nonatomic) MoviesSearchVC *vcToTest;

@end

@implementation MoviesSearchTestClass

- (void)setUp {
    [super setUp];
    self.vcToTest = [[MoviesSearchVC alloc] init];
    [self testVCCalled];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testVCCalled {
    NSString *checkedVC = @"MoviesSearchVCTest";
    [self.vcToTest checkVC:checkedVC];
    XCTAssertEqualObjects(@"", checkedVC, @"MoviesSearchVCTest not executed");
 }

@end
