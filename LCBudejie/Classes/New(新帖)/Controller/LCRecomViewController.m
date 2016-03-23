//
//  LCRecomViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCRecomViewController.h"
#import "LCRecomViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LCSubTagItem.h"
#import "LCSubTagCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface LCRecomViewController()

@property (nonatomic, strong) NSArray *subTagItems;
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end
@implementation LCRecomViewController

    NSString *const ID = @"cell";

//- (NSArray *)subTagItems
//{
//    if (_subTagItems == nil)
//    {
//        _subTagItems = [NSArray array];
//    }
//    return _subTagItems;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title= @"推荐标签";
    [self setupData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LCSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    // 清除系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LCColor(220, 220,221);
    [SVProgressHUD showWithStatus:@"正在加载ing....."];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
- (void)setupData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.manager = manager;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.subTagItems = [LCSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
   
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subTagItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.subTagItems[indexPath.row];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
