//
//  Tests.m
//  Tests
//
//  Created by Travis Jeffery on 4/17/14.
//
//

#import <XCTest/XCTest.h>
#import "TRVSURLSessionOperation.h"
#import "TRVSURLSessionDownloadOperation.h"

@interface Tests : XCTestCase

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation Tests

- (void)setUp {
    [super setUp];

    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 1;
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}

- (void)testData {
    NSArray *urls = @[ [NSURL URLWithString:@"https://twitter.com/travisjeffery"], [NSURL URLWithString:@"https://github.com/travisjeffery"] ];
    NSMutableArray *result = [[NSMutableArray alloc] init];

    [_queue addOperation:[[TRVSURLSessionOperation alloc] initWithSession:_session request:[NSURLRequest requestWithURL:urls[0]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        XCTAssert(result.count == 0);
        [result addObject:response.URL];
    }]];

    [_queue addOperation:[[TRVSURLSessionOperation alloc] initWithSession:_session URL:urls[1] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [result addObject:response.URL];
    }]];

    [_queue waitUntilAllOperationsAreFinished];

    XCTAssertEqualObjects(urls, result);
}

- (void)testDownload {
    NSArray *urls = @[ [NSURL URLWithString:@"https://twitter.com/travisjeffery"], [NSURL URLWithString:@"https://github.com/travisjeffery"] ];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [_queue addOperation:[[TRVSURLSessionDownloadOperation alloc] initWithSession:_session request:[NSURLRequest requestWithURL:urls[0]] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        XCTAssert(result.count == 0);
        XCTAssertNotNil(location);
        NSData *fileData = [NSData dataWithContentsOfURL:location];
        XCTAssertTrue([fileData length] != 0);
        [result addObject:response.URL];
    }]];
    
    [_queue addOperation:[[TRVSURLSessionDownloadOperation alloc] initWithSession:_session URL:urls[1] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        XCTAssertNotNil(location);
        NSData *fileData = [NSData dataWithContentsOfURL:location];
        XCTAssertTrue([fileData length] != 0);
        [result addObject:response.URL];
    }]];
    
    [_queue waitUntilAllOperationsAreFinished];
    
    XCTAssertEqualObjects(urls, result);
}

@end
