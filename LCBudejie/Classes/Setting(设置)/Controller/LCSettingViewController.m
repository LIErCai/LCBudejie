//
//  LCSettingViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCSettingViewController.h"
#import "LCCleanFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>


#define LCCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface LCSettingViewController()

@property (nonatomic, assign) NSInteger totalSize;

@end
@implementation LCSettingViewController

 static NSString *const ID = @"cell";
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸....."];
    [LCCleanFileTool getFileSizeWithFileName:LCCachePath completion:^(NSInteger totalSize) {
        self.totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [self sizeStr];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [LCCleanFileTool removeDirectoryPath:LCCachePath];
    
    self.totalSize = 0;
    [self.tableView reloadData];
}
- (NSString *)sizeStr
{
    NSString *sizeStr = @"清除缓存";
    NSInteger totalSize = self.totalSize;
    if (totalSize > (1000 * 1000))
    {
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr, sizeF];
    }else if (totalSize > 1000)
    {
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr, sizeF];
    }else if (totalSize > 0)
    {
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr, totalSize];
    }
    return sizeStr;
}
@end
