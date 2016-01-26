//
//  DataSaveToLocalOperation.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"
@interface DataSaveToLocalOperation : NSOperation
-(instancetype)initWithStore:(Store *)store;
@end
