//
//  DataSaveToLocalOperation.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "DataSaveToLocalOperation.h"


#import "DataDownloadOperation.h"
#import "DataCreateItemOperation.h"
@interface DataSaveToLocalOperation ()
@property (nonatomic, strong) Store *store;
@property (nonatomic, copy) NSData *data;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSManagedObjectContext* context;
@end
@implementation DataSaveToLocalOperation
-(instancetype)initWithStore:(Store *)store{
    self = [super init];
    if (self) {
        self.store = store;
        self.queuePriority = NSOperationQueuePriorityHigh;
    }
    return self;
}

- (void)main{
    for (NSOperation *operation in self.dependencies) {
        if ([operation isKindOfClass:[DataDownloadOperation class]]) {
            if ([operation isCancelled]) {
                [self cancel];
                return;
            }else{
                self.data = ((DataDownloadOperation*)operation).data;
                self.url = [((DataDownloadOperation*)operation).url absoluteString];
                break;
            }
        }
    }
    
    self.context = [self.store newPrivateContext];
    self.context.undoManager = nil;
    
    [self.context performBlockAndWait:^{
        [self loadLocal];
    }];
}

- (void)loadLocal{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass([StringItem class]) inManagedObjectContext:self.context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name=%@",self.url]];
    StringItem *currentItem = [[self.context executeFetchRequest:request error:nil] lastObject];
    if (self.url && self.data && currentItem) {
        [currentItem setFileData:[[NSData alloc]initWithData:self.data]];
        if ([self.context save:NULL]) {
//            NSLog(@"保存成功");
        }else{
//            NSLog(@"保存失败");
        }
    }
}

- (NSArray *)fetchAllEntityWithName:(NSString *)entityName{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:self.store.managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *eventArray = [[self.store.managedObjectContext
                            executeFetchRequest:request error:&error] mutableCopy];
    return eventArray;
}
- (void)cancel{
    [super cancel];
    NSLog(@"DataSaveToLocalOperation Cancelled");
}
@end
