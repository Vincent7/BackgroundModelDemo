//
//  DataOperationController.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "DataOperationController.h"
#import "Store.h"
@interface DataOperationController ()<NSFetchedResultsControllerDelegate,DataDownloadOperationDelegate>
@property (nonatomic, strong) NSOperationQueue* operationQueue;
@property (nonatomic, strong) Store *store;

@end

@implementation DataOperationController

- (id)init{
    self = [super init];
    if(self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 5;
        self.store = [[Store alloc] init];
        
        NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([StringItem class])];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"itemIndex" ascending:YES]];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.store.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultsController.delegate = self;
        
        [self.fetchedResultsController performFetch:NULL];
        
//        [self downloadImageWebList];
    }
    return self;
}
- (void)downloadImageWebList{
    NSURL *webUrl = [NSURL URLWithString:@"https://500px.com/patrickmarsonong"];
    DataDownloadOperation *downLoadOperation = [[DataDownloadOperation alloc]initWithURL:webUrl andStore:self.store];
//    [downLoadOperation addDependency:createOperation];
    [self.operationQueue addOperation:downLoadOperation];
}

- (void)createNewItemWithUrlString:(NSString *)urlString andIndex:(NSInteger)itemIndex{
    StringItem *item = [self fetchOneDataItemByIdentiferKey:@"itemIndex" andKeyValue:@(itemIndex) andItemClass:[StringItem class]];
    if (!item) {
        DataCreateItemOperation *createOperation = [[DataCreateItemOperation alloc]initWithStore:self.store andUrlString:urlString andItemIndex:itemIndex];
        [self.operationQueue addOperation:createOperation];
        NSLog(@"ItemIndex at:%@ create new item",@(itemIndex));
    }
}
- (id)fetchOneDataItemByIdentiferKey:(NSString *)keyString andKeyValue:(id)keyValue andItemClass:(Class)itemClass{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass(itemClass) inManagedObjectContext:self.store.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@=%@",keyString,[keyValue stringValue]]]];
    NSArray *arr = [self.store.managedObjectContext executeFetchRequest:request error:nil];
    if (arr.count == 1) {
        return [arr firstObject];
    }
    return nil;
}

- (void)addDownloadOperationWithUrl:(NSURL *)url andItemIndex:(NSInteger) itemIndex withDownloadingUIBlock:(void (^)(float))progressBlock{
    StringItem *stringItem = [self fetchOneDataItemByIdentiferKey:@"itemIndex" andKeyValue:@(itemIndex) andItemClass:[StringItem class]];
    if (stringItem) {
        DataDownloadOperation *op = [self findDownloadOperationWithUrl:url];
        if ((op && op.isExecuting) || stringItem.fileData != nil) {
            //已经执行了下载任务
            NSLog(@"ItemIndex at:%@ is downloading",@(itemIndex));
        }else{
            DataDownloadOperation *downLoadOperation = [[DataDownloadOperation alloc]initWithURL:url andStore:self.store];
            //        [downLoadOperation addDependency:createOperation];
            [self.operationQueue addOperation:downLoadOperation];
            downLoadOperation.delegate = self;
            downLoadOperation.progressCallback = ^(float progress){
                progressBlock(progress);
            };
            
            DataSaveToLocalOperation *saveLocalOperation = [[DataSaveToLocalOperation alloc]initWithStore:self.store];
            //        [saveLocalOperation addDependency:createOperation];
            [saveLocalOperation addDependency:downLoadOperation];
            [self.operationQueue addOperation:saveLocalOperation];
            
//            UpdateUserInterfaceOperation *updateUIOperation = [[UpdateUserInterfaceOperation alloc]initWithUpdateBlock:^{
//                //        NSArray *arrObjects = self.fetchedResultsController.fetchedObjects;
//                NSLog(@"NEED UPDATE USERINTERFACE");
//                
//            }];
//            [updateUIOperation addDependency:downLoadOperation];
//            [self.operationQueue addOperation:updateUIOperation];
            NSLog(@"ItemIndex at:%@ download operation start",@(itemIndex));
        }
        
    }else{
        NSLog(@"ERROR");
    }
}

- (void)cancelDownloadOperationWithUrl:(NSURL *)url{
    DataDownloadOperation *op = [self findDownloadOperationWithUrl:url];
    if (op && [op isExecuting]) {
        NSLog(@"ItemIndex at:%@ download operation is canceling",@([self.operationQueue.operations indexOfObject:op]));
        [op cancel];
    }
}
- (DataDownloadOperation *)findDownloadOperationWithUrl:(NSURL *)url{
    for (NSOperation *op in self.operationQueue.operations) {
        if ([op isKindOfClass:[DataDownloadOperation class]]) {
            DataDownloadOperation *ddOp = (DataDownloadOperation *)op;
            if ([ddOp.url.absoluteString isEqualToString:url.absoluteString]) {
                return ddOp;
            }
        }
    }
    return nil;
}
#pragma mark -
-(void)didDownloadOperationFinishedWithError:(NSError *)error andOperation:(DataDownloadOperation *)operation{
    if (error == nil) {
//        NSLog(@"Download operation is completed");
    }
}
-(void)downloadOperationIsExecutingWithOperation:(DataDownloadOperation *)operation{
    
}
#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.fetchedResultsDelegate && [self.fetchedResultsDelegate respondsToSelector:@selector(controllerDidChangeContent:)]) {
        [self.fetchedResultsDelegate controllerDidChangeContent:controller];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller {
    if (self.fetchedResultsDelegate && [self.fetchedResultsDelegate respondsToSelector:@selector(controllerWillChangeContent:)]) {
        [self.fetchedResultsDelegate controllerWillChangeContent:controller];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    if (self.fetchedResultsDelegate && [self.fetchedResultsDelegate respondsToSelector:@selector(controller:didChangeSection:atIndex:forChangeType:)]) {
        [self.fetchedResultsDelegate controller:controller didChangeSection:sectionInfo atIndex:sectionIndex forChangeType:type];
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    if (self.fetchedResultsDelegate && [self.fetchedResultsDelegate respondsToSelector:@selector(controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:)]) {
        [self.fetchedResultsDelegate controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    }
}
@end
