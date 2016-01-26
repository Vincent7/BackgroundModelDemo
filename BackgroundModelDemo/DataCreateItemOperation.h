//
//  DataCreateItemOperation.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/14.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"
@interface DataCreateItemOperation : NSOperation

-(instancetype)initWithStore:(Store *)store andUrlString:(NSString *)urlString andItemIndex:(NSInteger)itemIndex;
@end
