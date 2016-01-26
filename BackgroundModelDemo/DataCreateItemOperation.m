//
//  DataCreateItemOperation.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/14.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "DataCreateItemOperation.h"
@interface DataCreateItemOperation ()
@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) StringItem *currentEntity;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) NSInteger itemIndex;
@property (nonatomic, strong) NSManagedObjectContext* context;
@end

@implementation DataCreateItemOperation
-(instancetype)initWithStore:(Store *)store andUrlString:(NSString *)urlString andItemIndex:(NSInteger)itemIndex{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        self.itemIndex = itemIndex;
        self.store = store;
        self.queuePriority = NSOperationQueuePriorityVeryHigh;
    }
    return self;
}

- (void)main{
    
    self.context = [self.store newPrivateContext];
    self.context.undoManager = nil;
    
    [self.context performBlockAndWait:^{
        [self create];
    }];
}

//Create or load from local
- (void)create{
    //修改Entity
    
    
    self.currentEntity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([StringItem class]) inManagedObjectContext:self.context];
    [self.currentEntity setName:self.urlString];
    [self.currentEntity setItemIndex:self.itemIndex];
    [self.currentEntity setFileData:nil];
//    self.currentEntity.name = @"Hold on!!";
//    self.currentEntity.fileData = nil;
    if (self.currentEntity) {
        if ([self.context save:NULL]) {
            return;
        }
    }
    NSLog(@"保存失败");
}
@end
