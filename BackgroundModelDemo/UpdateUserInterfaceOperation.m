//
//  UpdateUserInterfaceOperation.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "UpdateUserInterfaceOperation.h"

@interface UpdateUserInterfaceOperation()
@property (nonatomic, copy) void (^userInterfaceUpdateCallback) (void);
@end

@implementation UpdateUserInterfaceOperation
-(instancetype)initWithUpdateBlock:(void (^)(void))userInterfaceUpdateCallback{
    self = [super init];
    if (self) {
        self.userInterfaceUpdateCallback = userInterfaceUpdateCallback;
    }
    return self;
}

-(void)main{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         self.userInterfaceUpdateCallback();
     }];
}
@end
