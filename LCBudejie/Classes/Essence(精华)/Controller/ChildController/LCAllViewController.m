//
//  LCAllViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCAllViewController.h"
#import <AFNetworking.h>
#import "LCTopic.h"
#import <MJExtension.h>
#import "LCTopicViewCell.h"
@interface LCAllViewController ()

@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, weak) UIView *footView;
@property (nonatomic, weak) UILabel *footLabel;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSString *maxtime;
@end

@implementation LCAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tableView.contentInset = UIEdgeInsetsMake(LCNavMaxY + LCTitleViewH, 0, LCTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:LCTabBarButtonDidRepeatClickNotification object:nil];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:LCTitleButtonDidRepeatClickNotification object:nil];
    
    
    [self setupHeaderFooterView];
    self.tableView.rowHeight = 300;
   
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
    
    [self setupHeaderView];
    [self setupFooterView];
}

- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, -35, self.view.lc_width, 35);
    [self.tableView addSubview:headerView];
    self.headerView = headerView;
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = headerView.bounds;
    headerLabel.text = @"下拉加载更多......";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = [UIColor redColor];
    [headerView addSubview:headerLabel];
    self.headerLabel = headerLabel;
    
    [self headerBeginRefreshing];
}
- (void)setupFooterView
{
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.view.lc_width, 35);
    footerView.backgroundColor = [UIColor blackColor];
    self.footView = footerView;

    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footerView.bounds;
    footerLabel.text = @"上拉加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.backgroundColor = [UIColor redColor];
    self.footLabel = footerLabel;
    [self.footView addSubview:footerLabel];
    
    self.tableView.tableFooterView = footerView;
}

- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
//    [self loadNewData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
      self.footView.hidden = (self.dataCount == 0);
    
      return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCTopicViewCell *cell = [LCTopicViewCell topicCellWithTableView:tableView];
    
    cell.topic = self.topics[indexPath.row];
//    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y <= -(self.tableView.contentInset.top + self.headerView.lc_height))
    {
        // 下拉刷新
        [self headerBeginRefreshing];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dealHeader];
    [self dealFooter];
    
    
}

- (void)headerBeginRefreshing
{
    if (self.isHeaderRefreshing) return;
    
      NSLog(@"%@", self.headerLabel.text);
    self.headerLabel.text = @"正在刷新.....";
    NSLog(@"%@", self.headerLabel.text);
    self.headerLabel.backgroundColor = [UIColor blueColor];
     self.headerRefreshing = YES;
       NSLog(@"%@", self.headerLabel.text);
    [UIView animateWithDuration:0.25 animations:^{
    
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headerView.lc_height;
        self.tableView.contentInset = inset;
        
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
//
    }];
    
    [self loadNewData];
     NSLog(@"%@", self.headerLabel.text);
}

- (void)loadNewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    [manager  GET:LCCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [LCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        NSLog(@"%@", self.topics);
        
#warning ----
        [self.tableView reloadData];
        [self headerEndRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self headerEndRefreshing];

    }];
    

}
- (void)headerEndRefreshing
{
//     self.headerLabel.text = @"下拉加载更多";
//    self.headerLabel.backgroundColor = [UIColor redColor];
    self.headerRefreshing = NO;
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headerView.lc_height;
        self.tableView.contentInset = inset;
    }];
    
    NSLog(@"%@----%@", NSStringFromCGPoint(self.tableView.contentOffset), NSStringFromUIEdgeInsets(self.tableView.contentInset) );
}
- (void)dealHeader
{
    if (self.isHeaderRefreshing) return;
    if (self.tableView.contentOffset.y <= (- (self.tableView.contentInset.top + self.headerView.lc_height)))
    {
        self.headerLabel.text = @"松开立即刷新...";
        self.headerLabel.backgroundColor = [UIColor purpleColor];
    }else
    {
        self.headerLabel.text = @"下拉加载更多...";
        self.headerLabel.backgroundColor = [UIColor redColor];
    }
}
- (void)dealFooter
{
    if (self.tableView.contentSize.height == 0) return;
    CGFloat ofsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.lc_height;
    
    if (self.tableView.contentOffset.y >= ofsetY && self.tableView.contentOffset.y > -self.tableView.contentInset.top)
    {
        //开始刷新
       [self footerBeginRefreshing];
    }

}
- (void)footerBeginRefreshing
{
    if (self.isFooterRefreshing) return ;
    self.footerRefreshing = YES;
    self.footLabel.text = @"正在刷新...";
    self.footLabel.backgroundColor = [UIColor blueColor];
    NSLog(@"%@----%@", NSStringFromCGRect(self.footLabel.frame),NSStringFromCGRect(self.footView.frame));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.dataCount += 5;
//        [self.tableView reloadData];
         [self loadMoreTopics];
        //结束刷新
//        [self  footerEndRefreshing];
    });
    
//    [self loadMoreTopics];
}


- (void)loadMoreTopics
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    parameters[@"maxtime"] = self.maxtime;
    [manager  GET:LCCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
       NSArray *arr = [LCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:arr];
#warning ----
        [self.tableView reloadData];
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self footerEndRefreshing];
    }];
    

}
- (void)footerEndRefreshing
{
    self.footLabel.text = @"上拉加载更多";
    self.footLabel.backgroundColor = [UIColor redColor];
    self.footerRefreshing = NO;
}
@end
