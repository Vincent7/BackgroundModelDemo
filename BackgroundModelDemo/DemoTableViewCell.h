//
//  DemoTableViewCell.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/13.
//  Copyright © 2016年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *textData;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIImageView *downloadImageView;

@end
