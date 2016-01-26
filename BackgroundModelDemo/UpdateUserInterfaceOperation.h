//
//  UpdateUserInterfaceOperation.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"
@interface UpdateUserInterfaceOperation : NSOperation

-(instancetype)initWithUpdateBlock:(void (^)(void))userInterfaceUpdateCallback;
@end
