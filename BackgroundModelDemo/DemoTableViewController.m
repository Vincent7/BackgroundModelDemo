//
//  DemoTableViewController.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/13.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "DemoTableViewController.h"
#import "DemoTableViewDataSource.h"
#import "DemoTableViewCell.h"
#import "StringItem.h"
@interface DemoTableViewController () <UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) DemoTableViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//设置预加载的IndexPath队列
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*arrLoadedIndexPaths;
@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrLoadedIndexPaths = [NSMutableArray array];
    
    self.dataSource = [[DemoTableViewDataSource alloc] initWithTableView:self.tableView andCellIdentifier:@"DemoTableViewCell" configureCellBlock:^(id cell, id item) {
        
        DemoTableViewCell *textCell = cell;
        //FIXME: 在cellForRowAtIndexPath中 Cell还没有开始绘制，不需要设置Image or text，这样会减慢cell实体的返回速度
        StringItem *stringItem = item;
        [textCell.titleLabel setText:stringItem.name];
        
        [textCell.progress setHidden:stringItem.fileData];
        [textCell.downloadImageView setImage:[UIImage imageWithData:stringItem.fileData]];
        [textCell.downloadImageView setContentMode:UIViewContentModeScaleAspectFit];
    }];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    for (int i = 0; i < 19; i++) {
        [self.dataSource initTableWithEmptyDataWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置Cell的属性
//    [self.dataSource downLoadDataWithIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //Cancel download
//    [self.dataSource cancelOperationWithIndexPath:indexPath];
}
- (void)updateVisibleCellIndexPathsForAddIndexPath:(NSIndexPath *)indexPath{
    //更新缓冲列表
    [self.arrLoadedIndexPaths addObject:indexPath];
}
- (void)updateVisibleCellIndexPathsForRemoveIndexPath:(NSIndexPath *)indexPath{
    //更新缓冲列表
    
    [self.arrLoadedIndexPaths removeObject:indexPath];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    NSArray *temp = [self.tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y - scrollView.bounds.size.height, scrollView.bounds.size.width, scrollView.bounds.size.height + scrollView.bounds.size.height *2)];
    
    NSMutableArray *addItems = [NSMutableArray array];
    NSMutableArray *removeItems = [NSMutableArray array];
    
    for (NSIndexPath *ip in temp) {
        BOOL indexPathExistInLoadedArray = NO;
        for (NSIndexPath *existingIp in self.arrLoadedIndexPaths) {
            if ([existingIp compare:ip] == NSOrderedSame) {
                indexPathExistInLoadedArray = YES;
                break;
            }
        }
        if (!indexPathExistInLoadedArray) {
            [addItems addObject:ip];
        }
    }
    for (NSIndexPath *existingIp in self.arrLoadedIndexPaths) {
        BOOL indexPathExistInTempArray = NO;
        for (NSIndexPath *ip in temp) {
            if ([existingIp compare:ip] == NSOrderedSame) {
                indexPathExistInTempArray = YES;
                break;
            }
        }
        if (!indexPathExistInTempArray) {
            [removeItems addObject:existingIp];
        }
    }
    
    self.arrLoadedIndexPaths = [NSMutableArray arrayWithArray:temp];
    for (NSIndexPath *ip in addItems) {
        [self.dataSource downLoadDataWithIndexPath:ip];
    }
    
    for (NSIndexPath *ip in removeItems) {
        [self.dataSource cancelOperationWithIndexPath:ip];
    }
}
//- (void)indexPathsNeedUpdate{
//    NSIndexPath *lowerLimitIndexPath = [[self.tableView indexPathsForVisibleRows] firstObject];
//    NSIndexPath *upperLimitIndexPath = [[self.tableView indexPathsForVisibleRows] firstObject];
//    
//    for (NSIndexPath *ip in [self.tableView indexPathsForVisibleRows]) {
//        if ([ip compare:lowerLimitIndexPath] == NSOrderedAscending) {
//            lowerLimitIndexPath = ip;
//        }
//    }
//    for (<#initialization#>; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
//    
//    for (NSIndexPath *ip in [self.tableView indexPathsForVisibleRows]) {
//        if ([ip compare:upperLimitIndexPath] == NSOrderedDescending) {
//            upperLimitIndexPath = ip;
//        }
//    }
//}
//- (NSIndexPath *)upperLimitIndexPath{
//    if (self.arrIndexPaths.count > 0) {
//        NSIndexPath *tempIndexPath = [self.arrIndexPaths firstObject];
//        for (NSIndexPath *ip in self.arrIndexPaths) {
//            if ([ip compare:tempIndexPath] == NSOrderedAscending) {
//                tempIndexPath = ip;
//            }
//        }
//        return tempIndexPath;
//    }else{
//        return nil;
//    }
//}
//- (NSIndexPath *)lowerLimitIndexPath{
//    if (self.arrIndexPaths.count > 0) {
//        NSIndexPath *tempIndexPath = [self.arrIndexPaths firstObject];
//        for (NSIndexPath *ip in self.arrIndexPaths) {
//            if ([ip compare:tempIndexPath] == NSOrderedDescending) {
//                tempIndexPath = ip;
//            }
//        }
//        return tempIndexPath;
//    }else{
//        return nil;
//    }
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"lalal");
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
