//
//  TRVSURLSessionDownloadOperation.m
//  TRVSURLSessionOperation
//
//  Created by Frank Lefebvre on 17/07/15.
//
//

#import "TRVSURLSessionDownloadOperation.h"
#import "TRVSAsynchronousOperation+Subclass.h"

@implementation TRVSURLSessionDownloadOperation

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler location:location response:response error:error];
        }];
    }
    return self;
}

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler location:location response:response error:error];
        }];
    }
    return self;
}

- (void)completeOperationWithBlock:(void (^)(NSURL *, NSURLResponse *, NSError *))block location:(NSURL *)location response:(NSURLResponse *)response error:(NSError *)error {
    if (!self.isCancelled && block)
        block(location, response, error);
    [self completeOperation];
}

- (void)startAsynchronousOperation {
    [self.task resume];
}

- (void)cancelAsynchronousOperation {
    [self.task cancel];
}

@end
