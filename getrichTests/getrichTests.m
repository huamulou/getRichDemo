//
//  getrichTests.m
//  getrichTests
//
//  Created by huamulou on 14-9-24.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
@interface getrichTests : XCTestCase

@property (nonatomic, retain)NSString *abc;
@property (nonatomic, retain)NSString *def;
@end

@implementation getrichTests

- (void)setUp
{
    [super setUp];
    _abc= @"abc";
    _def= @"def";
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSString *j = _abc;
    _abc =nil;

    NSString *key = @"1234";
    objc_setAssociatedObject(self, &key, @"12121", OBJC_ASSOCIATION_RETAIN) ;
    objc_setAssociatedObject(self, &key, @"3333", OBJC_ASSOCIATION_RETAIN) ;
    objc_setAssociatedObject(self, &key, @"4444", OBJC_ASSOCIATION_RETAIN) ;

    NSLog(objc_getAssociatedObject(self, &key));
    NSLog(@"_______%@, %@", _abc, j);
    _abc = _def;
    NSLog(@"_______%@, %@", _abc, j);

    _def  = j;
    NSLog(@"_______%@, %@, %@", _abc, j, _def);

    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
