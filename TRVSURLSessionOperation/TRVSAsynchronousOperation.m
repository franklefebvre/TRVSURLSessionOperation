//
//  TRVSAsynchronousOperation.m
//  TRVSURLSessionOperation
//
//  Created by Frank Lefebvre on 17/07/15.
//
//

#import "TRVSAsynchronousOperation.h"
#import "TRVSAsynchronousOperation+Subclass.h"

#define TRVSKVOBlock(KEYPATH, BLOCK) \
    [self willChangeValueForKey:KEYPATH]; \
    BLOCK(); \
    [self didChangeValueForKey:KEYPATH];

@implementation TRVSAsynchronousOperation {
    BOOL _finished;
    BOOL _executing;
}

- (void)cancel {
    [super cancel];
    [self cancelAsynchronousOperation];
}

- (void)start {
    if (self.isCancelled) {
        TRVSKVOBlock(@"isFinished", ^{ _finished = YES; });
        return;
    }
    TRVSKVOBlock(@"isExecuting", ^{
        [self startAsynchronousOperation];
        _executing = YES;
    });
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)startAsynchronousOperation {
}

- (void)cancelAsynchronousOperation {
}

@end
