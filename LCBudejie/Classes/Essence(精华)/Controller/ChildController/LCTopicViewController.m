//
//  LCTopicViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTopicViewController.h"
#import <AFNetworking.h>
#import "LCTopic.h"
#import <MJExtension.h>
#import "LCTopicViewCell.h"
#import <SVProgressHUD.h>
#import <MJRefresh.h>

@interface LCTopicViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
//@property (nonatomic, weak) UIView *footView;
//@property (nonatomic, weak) UILabel *footLabel;
//@property (nonatomic, weak) UIView *headerView;
//@property (nonatomic, weak) UILabel *headerLabel;
//@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
//@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSString *maxtime;

@end

@implementation LCTopicViewController

static NSString *const LCTopicCellId = @"LCTopicCellId";


- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LCColor(206, 206, 206);
    self.tableView.contentInset = UIEdgeInsetsMake(LCNavMaxY + LCTitleViewH, 0, LCTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:LCTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:LCTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupHeaderFooterView];
    
    //    self.tableView.rowHeight = 250;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LCTopicViewCell" bundle:nil] forCellReuseIdentifier:LCTopicCellId];
    
    
    
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupHeaderFooterView
{
    //广告条
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blackColor];
    label.text = @"广告";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(0, 0, self.view.lc_width, 30);
    self.tableView.tableHeaderView = label;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
   
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}



- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//    self.footView.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LCTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LCTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    //    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCTopic *topic = self.topics[indexPath.row];
    
    
    return topic.rowHeight;
}

- (void)loadNewData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    [self.manager  GET:LCCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [LCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
         [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code != NSURLErrorCancelled)
        {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试!"];
        }
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    
}
- (void)loadMoreTopics
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    [self.manager  GET:LCCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *arr = [LCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:arr];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code != NSURLErrorCancelled)
        {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试!"];
        }
         [self.tableView.mj_footer endRefreshing];
    }];
    
    
}
@end
