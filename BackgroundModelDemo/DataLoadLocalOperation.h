//
//  DataLoadLocalOperation.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/12.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"
@interface DataLoadLocalOperation : NSOperation

-(id)initWithStore:(Store *)store andData:(id)data;

@end
