//
//  DataDownloadOperation.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

@protocol DataDownloadOperationDelegate;
#import <Foundation/Foundation.h>
#import "Store.h"
@interface DataDownloadOperation : NSOperation
- (id)initWithURL:(NSURL*)url andStore:(Store*)store;
@property (nonatomic, readonly) NSError* error;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) NSData* data;
@property (nonatomic, strong) Store *store;
@property (nonatomic, copy) void (^progressCallback) (float);
@property (nonatomic, weak) id <DataDownloadOperationDelegate>delegate;
@end

@protocol DataDownloadOperationDelegate <NSObject>

@optional
- (void)didDownloadOperationFinishedWithError:(NSError *)error andOperation:(DataDownloadOperation *)operation;
- (void)downloadOperationIsExecutingWithOperation:(DataDownloadOperation *)operation;
@end