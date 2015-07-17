//
//  TRVSURLSessionDownloadOperation.h
//  TRVSURLSessionOperation
//
//  Created by Frank Lefebvre on 17/07/15.
//
//

#import "TRVSAsynchronousOperation.h"

@interface TRVSURLSessionDownloadOperation : TRVSAsynchronousOperation

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;
- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;

@property (nonatomic, strong, readonly) NSURLSessionDownloadTask *task;

@end
