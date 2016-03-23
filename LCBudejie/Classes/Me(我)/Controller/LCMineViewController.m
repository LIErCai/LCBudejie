//
//  LCMineViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCMineViewController.h"
#import "UIBarButtonItem+LC.h"
#import "LCSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "LCSquareItem.h"
#import "LCSquareCell.h"
#import "LCWebViewController.h"
@interface LCMineViewController()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, weak) UICollectionView *collectionView;


@end
@implementation LCMineViewController

static NSString *const ID = @"cell";
static NSInteger  const totalCol = 4;
static CGFloat const margin = 1;
#define layoutWH  (LCScreenW - margin * (totalCol - 1)) / totalCol


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBarItem];
    [self setupData];
    
    [self setupFooterView];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self.tableView reloadData];
}

- (void)setupFooterView
{
   ;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(layoutWH, layoutWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 500) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    self.collectionView = collectionView;
    self.tableView.tableFooterView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LCSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squares.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
    cell.item = self.squares[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCSquareItem *item = self.squares[indexPath.item];
    if (![item.url containsString:@"http"]) return ;
    LCWebViewController *webView = [[LCWebViewController alloc] init];
    webView.url = item.url;
    [self.navigationController pushViewController:webView animated:YES];
}
- (void)setupData
{
    [SVProgressHUD showInfoWithStatus:@"正在加载......"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.squares = [LCSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        [self resloveData];
        self.collectionView.lc_height = self.squares.count / totalCol * layoutWH + 10;
        self.tableView.tableFooterView = self.collectionView;
//        self.tableView.lc_height = CGRectGetMaxY(self.collectionView.frame);
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)resloveData
{
    NSInteger count = self.squares.count;
    NSInteger exter = count % totalCol;
    if(exter)
    {
        exter = totalCol - exter;
        for (int i = 0; i < exter; i++)
        {
            LCSquareItem *itme = [[LCSquareItem alloc] init];
            [self.squares addObject:itme];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD  dismiss];
}
- (void)setBarItem
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] hightImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(mineSettingIconClick)];
    
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(mineMoonClick:)];
    self.navigationItem.rightBarButtonItems = @[item1, item2];
    
}

- (void)mineMoonClick:(UIButton *)button
{
    button.selected = !button.selected;
}
- (void)mineSettingIconClick
{
    LCSettingViewController *setVc = [[LCSettingViewController alloc] init];
    [self.navigationController pushViewController:setVc animated:YES];
}
@end
