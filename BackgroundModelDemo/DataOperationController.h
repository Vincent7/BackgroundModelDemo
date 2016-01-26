//
//  DataOperationController.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

@protocol DataOperationControllerFetchedResultsDelegate;

#import <Foundation/Foundation.h>
#import "DataDownloadOperation.h"
#import "DataLoadLocalOperation.h"
#import "UpdateUserInterfaceOperation.h"
#import "DataCreateItemOperation.h"
#import "DataSaveToLocalOperation.h"
@class Store;

@interface DataOperationController : NSObject
@property (nonatomic, weak) id<DataOperationControllerFetchedResultsDelegate> fetchedResultsDelegate;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
- (id)init;
- (void)createNewItemWithUrlString:(NSString *)urlString andIndex:(NSInteger)itemIndex;
- (void)addDownloadOperationWithUrl:(NSURL *)url andItemIndex:(NSInteger) itemIndex withDownloadingUIBlock:(void (^)(float))progressBlock;
- (void)cancelDownloadOperationWithUrl:(NSURL *)url;
//- (void)addLoadLocalOperationWithData:(id)data;
@end

@protocol DataOperationControllerFetchedResultsDelegate <NSObject>

@optional
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller;
- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller;
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type;
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath;
@end