//
//  DataLoadLocalOperation.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "DataLoadLocalOperation.h"
#import "DataDownloadOperation.h"
#import "DataCreateItemOperation.h"
@interface DataLoadLocalOperation ()
@property (nonatomic, strong) StringItem *loadItem;
@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) NSManagedObjectContext* context;
@end
@implementation DataLoadLocalOperation
-(instancetype)initWithStore:(Store *)store andData:(id)data{
    self = [super init];
    if (self) {
        StringItem *item = (StringItem*)data;
        self.loadItem = item;
        self.store = store;
    }
    return self;
}

- (void)main{

}

- (void)loadLocal{
    
}

@end
