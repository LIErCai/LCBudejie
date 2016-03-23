//
//  LCADViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCADViewController.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "LCADItem.h"
#import "LCTabBarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
@interface LCADViewController()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *adContentView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

@property (nonatomic, weak) UIImageView *adView;
@property (nonatomic, strong) LCADItem *item;
@property (nonatomic, weak) NSTimer *timer;

@end
@implementation LCADViewController
- (void)viewDidLoad
{
    [super  viewDidLoad];
    
    [self setupLaunchImage];
    [self loadData];
    
   self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}


- (void)timeChange
{
   static int i = 3;
    
    if (i == 0)
    {
        [self jumpButton:nil];
    }
    i--;
   
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过(%d)", i] forState:UIControlStateNormal];
}
- (UIImageView *)adView
{
    if (_adView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adContentView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView = imageView;
    }
    return _adView;
}

- (void)tap
{
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
    if ([app canOpenURL:url])
    {
        [app openURL:url];
    }
}
- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    margin.responseSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        self.item = [LCADItem mj_objectWithKeyValues:adDict];
        CGFloat adViewH = LCScreenW * self.item.h / self.item.w;
        self.adView.frame = CGRectMake(0, 0, LCScreenW, adViewH);
        [self.adView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
- (void)setupLaunchImage
{
    if (iphone6P)
    {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if(iphone6)
    {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iphone5)
    {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if(iphone4)
    {
        self.imageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
        
    
}
- (IBAction)jumpButton:(id)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LCTabBarController alloc] init];
    
    [self.timer invalidate];
    
}
@end
