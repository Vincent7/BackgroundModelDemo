//
//  DemoTableViewDataSource.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/13.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);
@interface DemoTableViewDataSource : NSObject <UITableViewDataSource>

- (id)initWithTableView:(UITableView *)tableView andCellIdentifier:(NSString *)identifier configureCellBlock:(TableViewCellConfigureBlock)cellBlock;
-(id)itemAtIndexPath:(NSIndexPath *)indexPath;

-(void)downLoadDataWithIndexPath:(NSIndexPath *)indexPath;
-(void)initTableWithEmptyDataWithIndexPath:(NSIndexPath *)indexPath;
- (void)cancelOperationWithIndexPath:(NSIndexPath *)indexPath;
@end
