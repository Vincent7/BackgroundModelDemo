//
//  DemoTableViewDataSource.m
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/13.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import "DemoTableViewDataSource.h"
#import "DemoTableViewCell.h"
#import "DataOperationController.h"
@interface DemoTableViewDataSource() <DataOperationControllerFetchedResultsDelegate>
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
//@property (nonatomic, strong) NSMutableArray *arrDataObjects;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DataOperationController *operationController;

@property (nonatomic, strong) NSMutableArray *arrDataSourceStringPath;
@end
@implementation DemoTableViewDataSource

-(NSMutableArray *)arrDataSourceStringPath{
    NSArray *arrTemp = [NSArray array];
    arrTemp = @[@"https://drscdn.500px.org/photo/136077281/m%3D1170/9ebe793a1526a9d6edcea3734cdca284",
                @"https://drscdn.500px.org/photo/135840469/m%3D1170/8cb58219289319a6f0305ba16c788315",
                @"https://drscdn.500px.org/photo/135092085/m%3D1170/6430a0896ee222da82353092cd8661fa",
                @"https://drscdn.500px.org/photo/134816909/m%3D1170/a138f9cccc6eed08fe10604fdc8502ca",
                @"https://drscdn.500px.org/photo/132599853/m%3D1170/5d976debe6c301338b23f4e82e12553f",
                @"https://drscdn.500px.org/photo/136077281/m%3D900/4f983cc0fb76419fdf7572d9b9a6b5ce",
                @"https://drscdn.500px.org/photo/135840469/m%3D900/611173aa6f3e61aa01679505303cc81d",
                @"https://drscdn.500px.org/photo/135092085/m%3D900/39b6e386430225e5dea9f412aff2ba75",
                @"https://drscdn.500px.org/photo/134816909/m%3D900/995b2ab96ca51c49ec3b08b28c344e2b",
                @"https://drscdn.500px.org/photo/135840469/h%3D300/f087e846cbe814e29fc48a00e696cebb",
                @"https://drscdn.500px.org/photo/135092085/h%3D300/1358ecb4ab5a33af820d00b096fc1bfd",
                @"https://drscdn.500px.org/photo/134816909/h%3D300/cac869615b5324a7139fdb4e333aa2cf",
                @"https://drscdn.500px.org/photo/132599853/h%3D300/05de7127c6d59fe00afa6b622b3cf1b7",
                @"https://drscdn.500px.org/photo/132399371/h%3D300/c6b18b1dc492ab42b04bffac53020631",
                @"https://drscdn.500px.org/photo/131843701/h%3D300/84622cc590eff74d70c45bb805c2e3f5",
                @"https://drscdn.500px.org/photo/131622617/h%3D450/f89842e4fa2ae83f28a21cda49065811",
                @"https://drscdn.500px.org/photo/131019423/h%3D450/e551afa8cc35a3a48588bab877a7ce74",
                @"https://drscdn.500px.org/photo/130805797/h%3D450/40c4c0956ef713de5c3a6389b6f10605",
                @"https://drscdn.500px.org/photo/130556213/h%3D450/f67bd9feb6dd4391514348a1c6d379f6"];
//    arrTemp = @[@"http://ipv4.download.thinkbroadband.com/1MB.zip",
//                @"http://ipv4.download.thinkbroadband.com/2MB.zip",
//                @"http://ipv4.download.thinkbroadband.com/5MB.zip"
//                ];
    return [NSMutableArray arrayWithArray:arrTemp];
}

- (id)initWithTableView:(UITableView *)tableView andCellIdentifier:(NSString *)identifier configureCellBlock:(TableViewCellConfigureBlock)cellBlock{
    self = [super init];
    if (self) {
        self.cellIdentifier = identifier;
        self.configureCellBlock = [cellBlock copy];
//        self.arrDataObjects = [NSMutableArray array];
        self.operationController = [[DataOperationController alloc]init];
        self.operationController.fetchedResultsDelegate = self;
        self.tableView = tableView;
        
        
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                      forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell,item);
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.operationController.fetchedResultsController.sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger i = [self.operationController.fetchedResultsController.sections[(NSUInteger) section] numberOfObjects];
    return i;
}
-(id)itemAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section = 0;
//    NSInteger row = indexPath.row;
    return [self.operationController.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
}

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)path {
    id item = [self itemAtIndexPath:path];
    if(self.configureCellBlock) {
        self.configureCellBlock(cell, item);
    }
}
//当indexPath处于（需要缓冲的位置时）开始缓冲
//同事在离开缓冲位置时没有缓冲结束的话Cancel Operation
-(void)downLoadDataWithIndexPath:(NSIndexPath *)indexPath{
    NSString *urlString = [self.arrDataSourceStringPath objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:urlString];
    
    __block DemoTableViewDataSource *weakSelf = self;
    [self.operationController addDownloadOperationWithUrl:url andItemIndex:indexPath.row  withDownloadingUIBlock:^(float progress) {
        DemoTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
        if (cell) {
            cell.progress.progress = progress;
        }
    }];
}
- (void)cancelOperationWithIndexPath:(NSIndexPath *)indexPath{
    NSString *urlString = [self.arrDataSourceStringPath objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self.operationController cancelDownloadOperationWithUrl:url];
}
-(void)initTableWithEmptyDataWithIndexPath:(NSIndexPath *)indexPath{
    NSString *urlString = [self.arrDataSourceStringPath objectAtIndex:indexPath.row];
    [self.operationController createNewItemWithUrlString:urlString andIndex:indexPath.row];
}
#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationBottom];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationBottom];
            break;
        default:
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationBottom];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationBottom];
            break;
            
        case NSFetchedResultsChangeUpdate:
            if([self.tableView.indexPathsForVisibleRows indexOfObject:indexPath] != NSNotFound) {
                [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            break;
            
        case NSFetchedResultsChangeMove:
            if ([indexPath compare:newIndexPath] == NSOrderedSame) {
                [self.tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                      withRowAnimation:UITableViewRowAnimationBottom];
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                      withRowAnimation:UITableViewRowAnimationBottom];
            }
            
            break;
        default:
            break;
    }
}
@end
