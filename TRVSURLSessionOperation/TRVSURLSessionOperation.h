//
//  TRVSQueuedURLSesssion.h
//  TRVSURLSessionOperation
//
//  Created by Travis Jeffery on 4/17/14.
//  Copyright (c) 2014 Travis Jeffery. All rights reserved.
//

#import "TRVSAsynchronousOperation.h"

@interface TRVSURLSessionOperation : TRVSAsynchronousOperation

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

@end
