////
////  DataDownloadOperation.m
////  BackgroundModelDemo
////
////  Created by Vincent on 16/1/12.
////  Copyright © 2016年 Vincent. All rights reserved.
////
//
////
////  DataDownloadOperation.m
////  BackgroundModelDemo
////
////  Created by Vincent on 16/1/12.
////  Copyright © 2016年 Vincent. All rights reserved.
////
//
//#import "DataDownloadOperation.h"
//
//@interface DataDownloadOperation ()<NSURLConnectionDelegate>
//
//@property (nonatomic, strong) NSURLConnection* connection;
//@property (nonatomic, strong) NSMutableData* buffer;
//@property (nonatomic) long long int expectedContentLength;
//@property (nonatomic, readwrite) NSError* error;
//@property (nonatomic) BOOL isExecuting;
//@property (nonatomic) BOOL isConcurrent;
//@property (nonatomic) BOOL isFinished;
//@end
//
//@implementation DataDownloadOperation
//- (id)initWithURL:(NSURL*)url andStore:(Store *)store{
//    self = [super init];
//    if(self) {
//        self.url = url;
//        self.queuePriority = NSOperationQueuePriorityNormal;
//        self.store = store;
//    }
//    return self;
//}
//
//- (void)start{
//    NSURLRequest* request = [NSURLRequest requestWithURL:self.url];
//    self.isExecuting = YES;
//    self.isConcurrent = YES;
//    self.isFinished = NO;
//    [self.store.managedObjectContext performBlock:^{
//        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    }];
//    //    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//    //         self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    //    }];
//}
//
//#pragma mark NSURLConnectionDelegate
////- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
////    return request;
////}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    self.expectedContentLength = response.expectedContentLength;
//    self.buffer = [NSMutableData data];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [self.buffer appendData:data];
//    self.progressCallback(self.buffer.length / (float)self.expectedContentLength);
//}
//
//
////- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
////    return cachedResponse;
////}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    self.data = self.buffer;
//    //    NSMutableArray *arrImageUrls = [NSMutableArray array];
//    //    NSString *webBody = [[NSString alloc] initWithData:self.data encoding:NSASCIIStringEncoding];
//    //    NSError *error;
//    //    // 创建NSRegularExpression对象并指定正则表达式
//    ////    @"(https://drscdn.500px.org/photo/)((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
//    //    NSRegularExpression *regex = [NSRegularExpression
//    //                                  regularExpressionWithPattern:@"(https://)(drscdn.500px.org/photo/)([0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?"
//    //
//    //                                  options:0
//    //                                  error:&error];
//    //    if (!error) { // 如果没有错误
//    //        // 获取特特定字符串的范围
//    //        NSArray *allResult = [regex matchesInString:webBody
//    //                                            options:0
//    //                                              range:NSMakeRange(0, [webBody length])];
//    //        for (NSTextCheckingResult *match in allResult) {
//    //            if (match) {
//    //                // 截获特定的字符串
//    //                [arrImageUrls addObject:[webBody substringWithRange:match.range]];
//    //                NSString *result = [webBody substringWithRange:match.range];
//    //                NSLog(@"%@",result);
//    //            }
//    //        }
//    //    } else { // 如果有错误，则把错误打印出来
//    //        NSLog(@"error - %@", error);
//    //    }
//    //    <meta content="https://drscdn.500px.org/photo%@" property="og:image">
//    self.buffer = nil;
//    self.isExecuting = NO;
//    self.isFinished = YES;
//    //    ((http|ftp|https)://)
//    //    (([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})) (drscdn.500px.org)
//    //    (:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?
//    
//    //    ((http|ftp|https)://)(drscdn.500px.org/photo/)
//    //    (     ([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})
//    //          |
//    //          ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})
//    //    )
//    //    (:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?
//}
//
//- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error{
//    self.error = error;
//    self.isExecuting = NO;
//    self.isFinished = YES;
//}
//
//- (void)setIsExecuting:(BOOL)isExecuting{
//    [self willChangeValueForKey:@"isExecuting"];
//    _isExecuting = isExecuting;
//    [self didChangeValueForKey:@"isExecuting"];
//}
//
//
//- (void)setIsFinished:(BOOL)isFinished{
//    [self willChangeValueForKey:@"isFinished"];
//    _isFinished = isFinished;
//    [self didChangeValueForKey:@"isFinished"];
//}
//
//- (void)cancel{
//    [super cancel];
//    [self.connection cancel];
//    self.isFinished = YES;
//    self.isExecuting = NO;
//}
//-(void)didChangeValueForKey:(NSString *)key{
//    [super didChangeValueForKey:key];
//    if ([key isEqualToString:@"isFinished"]) {
//        if (self.isFinished && self.delegate && [self.delegate respondsToSelector:@selector(didDownloadOperationFinishedWithError:andOperation:)]) {
//            [self.delegate didDownloadOperationFinishedWithError:self.error andOperation:self];
//        }
//    }else if ([key isEqualToString:@"isExecuting"]){
//        if (self.isExecuting && self.delegate && [self.delegate respondsToSelector:@selector(downloadOperationIsExecutingWithOperation:)]) {
//            [self.delegate downloadOperationIsExecutingWithOperation:self];
//        }
//    }
//}
//@end

#import "DataDownloadOperation.h"
//#import "NSUR"
@interface DataDownloadOperation ()<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;//NSURLSession* session;
@property (nonatomic, strong) NSURLSession* downloadSession;
//@property (nonatomic, strong) nsurldo
//@property (nonatomic, strong) NSURLConnection* connection;

@property (nonatomic) float expectedContentLength;
@property (nonatomic, readwrite) NSError* error;

@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isConcurrent;
@property (nonatomic) BOOL isFinished;
@end

@implementation DataDownloadOperation
- (id)initWithURL:(NSURL*)url andStore:(Store *)store{
    self = [super init];
    if(self) {
        self.url = url;
        self.queuePriority = NSOperationQueuePriorityNormal;
        self.store = store;
    }
    return self;
}

- (void)start{
//    NSURLRequest* request = [NSURLRequest requestWithURL:self.url];
    self.isExecuting = YES;
    self.isConcurrent = YES;
    self.isFinished = NO;

    [self.store.managedObjectContext performBlock:^{
//        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
//        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        self.downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//        self.downloadTask = [self.downloadSession dataTaskWithURL:self.url];
//        [self.downloadTask resume];
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.downloadSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        NSURL *url = self.url;
        self.downloadTask = [self.downloadSession downloadTaskWithURL: url];
        [self.downloadTask resume];
    }];

}

#pragma mark NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    if (downloadTask.error) {
        
        self.error = downloadTask.error;
        self.isExecuting = NO;
        self.isFinished = YES;
    }else{
        self.data = [NSData dataWithContentsOfURL:location];
        self.isExecuting = NO;
        self.isFinished = YES;
    }
}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.progressCallback((double)totalBytesWritten/(double)totalBytesExpectedToWrite);

}


#pragma mark NSURLConnectionDelegate
//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
//    return request;
//}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    self.expectedContentLength = response.expectedContentLength;
//    self.buffer = [NSMutableData data];
//}

//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [self.buffer appendData:data];
//    self.progressCallback(self.buffer.length / (float)self.expectedContentLength);
//}


//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
//    return cachedResponse;
//}

//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    self.data = self.buffer;
////    NSMutableArray *arrImageUrls = [NSMutableArray array];
////    NSString *webBody = [[NSString alloc] initWithData:self.data encoding:NSASCIIStringEncoding];
////    NSError *error;
////    // 创建NSRegularExpression对象并指定正则表达式
//////    @"(https://drscdn.500px.org/photo/)((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
////    NSRegularExpression *regex = [NSRegularExpression
////                                  regularExpressionWithPattern:@"(https://)(drscdn.500px.org/photo/)([0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?"
////                                  
////                                  options:0
////                                  error:&error];
////    if (!error) { // 如果没有错误
////        // 获取特特定字符串的范围
////        NSArray *allResult = [regex matchesInString:webBody
////                                            options:0
////                                              range:NSMakeRange(0, [webBody length])];
////        for (NSTextCheckingResult *match in allResult) {
////            if (match) {
////                // 截获特定的字符串
////                [arrImageUrls addObject:[webBody substringWithRange:match.range]];
////                NSString *result = [webBody substringWithRange:match.range];
////                NSLog(@"%@",result);
////            }
////        }
////    } else { // 如果有错误，则把错误打印出来
////        NSLog(@"error - %@", error);
////    }
////    <meta content="https://drscdn.500px.org/photo%@" property="og:image">
//    self.buffer = nil;
//    self.isExecuting = NO;
//    self.isFinished = YES;
////    ((http|ftp|https)://)
////    (([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})) (drscdn.500px.org)
////    (:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?
//    
//    //    ((http|ftp|https)://)(drscdn.500px.org/photo/)
//    //    (     ([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})
//    //          |
//    //          ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})
//    //    )
//    //    (:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?
//}
//
//- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error{
//    self.error = error;
//    self.isExecuting = NO;
//    self.isFinished = YES;
//}

- (void)setIsExecuting:(BOOL)isExecuting{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}


- (void)setIsFinished:(BOOL)isFinished{
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancel{
    [super cancel];
    [self.downloadTask cancel];
//    [self.connection cancel];
    self.isFinished = YES;
    self.isExecuting = NO;
}
-(void)didChangeValueForKey:(NSString *)key{
    [super didChangeValueForKey:key];
    if ([key isEqualToString:@"isFinished"]) {
        if (self.isFinished && self.delegate && [self.delegate respondsToSelector:@selector(didDownloadOperationFinishedWithError:andOperation:)]) {
            [self.delegate didDownloadOperationFinishedWithError:self.error andOperation:self];
        }
    }else if ([key isEqualToString:@"isExecuting"]){
        if (self.isExecuting && self.delegate && [self.delegate respondsToSelector:@selector(downloadOperationIsExecutingWithOperation:)]) {
            [self.delegate downloadOperationIsExecutingWithOperation:self];
        }
    }
}
@end
