//
//  LCEssenceViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCEssenceViewController.h"
#import "UIBarButtonItem+LC.h"
#import "LCTitleButton.h"

#import "LCAllViewController.h"
#import "LCVideoViewController.h"
#import "LCSoundViewController.h"
#import "LCPictureViewController.h"
#import "LCPieceViewController.h"
@interface  LCEssenceViewController()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) LCTitleButton *selectorBtn;

@property (nonatomic, weak) UIView *titleLineView;

@end
@implementation LCEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

   // 设置导航条内容
    [self setBarItem];
    
    [self setupAllChildController];
    [self setupScrollView];
    [self setupTitleView];

    
}



- (void)setBarItem
{
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.image = [UIImage imageNamed:@"MainTitle"];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
       self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] hightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] hightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:nil action:nil];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / LCScreenW + 0.5;
//    [self titleClick:self.titleView.subviews[i]];
      [self dealTitleClick:self.titleView.subviews[i]];
}
- (void)setupAllChildController
{
    LCAllViewController *allVc = [[LCAllViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    LCVideoViewController *videoVc = [[LCVideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    LCSoundViewController *soundVc = [[LCSoundViewController alloc] init];
    soundVc.title = @"声音";
    [self addChildViewController:soundVc];
    
    LCPictureViewController *pictureVc = [[LCPictureViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    LCPieceViewController *pieceVc = [[LCPieceViewController alloc] init];
    pieceVc.title = @"段子";
    [self addChildViewController:pieceVc];
}
- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    CGFloat titleX = 0;
    CGFloat titleY = self.navigationController.navigationBarHidden?20:64;
    titleView.frame = CGRectMake(titleX, titleY, LCScreenW, 35);
    titleView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    self.titleView = titleView;
    
    //设置所有的标题按钮
    [self addAllTitle];
    //设置标题下划线
    [self addTitleLine];
    [self.view addSubview:titleView];
}
/**
 *   设置标题下划线
 */
- (void)addTitleLine
{
    UIView *titleLineView = [[UIView alloc] init];
    LCTitleButton *button = self.titleView.subviews.firstObject;
    button.selected = YES;
    self.selectorBtn = button;
    [button.titleLabel sizeToFit];
    titleLineView.lc_height = 1;
    titleLineView.lc_y = self.titleView.lc_height - titleLineView.lc_height;
    titleLineView.lc_width = button.titleLabel.lc_width;
    titleLineView.lc_centerX = button.lc_centerX;
    
    titleLineView.backgroundColor = [button titleColorForState:UIControlStateSelected];
    self.titleLineView = titleLineView;
    [self.titleView addSubview:titleLineView];
    
}
/**
 *  设置所有的标题按钮
 */
- (void)addAllTitle
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX;
    CGFloat btnY = 0;
    CGFloat btnW = LCScreenW / count;
    CGFloat btnH = self.titleView.lc_height;
    for (int i = 0; i < count; i++)
    {
        btnX = i * btnW;
        UIViewController *vc = self.childViewControllers[i];
        LCTitleButton *button = [[LCTitleButton alloc] init];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.titleView addSubview:button];
        button.tag = i;
        [button  addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:vc.title forState:UIControlStateNormal];
       
        
        if (i == 0)
        {
            [self titleClick:button];
//           
        }
    }
}
- (void)titleClick:(LCTitleButton *)btn
{
    if (self.selectorBtn == btn)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LCTitleButtonDidRepeatClickNotification object:nil];
    }
    [self dealTitleClick:btn];
    
}

- (void)dealTitleClick:(LCTitleButton *)btn
{
    self.selectorBtn.selected = NO;
    
    
    btn.selected = YES;
    self.selectorBtn = btn;
    NSInteger i = btn.tag;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.titleLineView.lc_width = self.selectorBtn.titleLabel.lc_width;
        self.titleLineView.lc_centerX = btn.lc_centerX;
    }];
    [self setupChildView:i];

}
- (void)setupChildView:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    [self.scrollView setContentOffset:CGPointMake(i * LCScreenW , 0) animated:YES];
    
    for (int index = 0; index < self.childViewControllers.count; index++)
    {
        UIViewController *vc = self.childViewControllers[index];
        if (!vc.isViewLoaded) continue;
        UIView *view = vc.view;
        if (![view isKindOfClass:[UIScrollView class]]) continue;
        UIScrollView *scrollView = (UIScrollView *)view;
        scrollView.scrollsToTop = (i == index);
    }
    
    
    // 如果view已经加载过 就直接返回
    if (vc.isViewLoaded) return ;
    CGFloat vcX = i * LCScreenW;
    CGFloat vcY = 0;
    CGFloat vcW = self.scrollView.lc_width;
    CGFloat vcH = self.scrollView.lc_height;
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [self.scrollView addSubview:vc.view];
    
    
  
    
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
  
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(LCScreenW * self.childViewControllers.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
   
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
   
    
}
- (void)viewDidLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    CGFloat titleX = 0;
//    CGFloat titleY = self.navigationController.navigationBarHidden?20:64;
//    self.titleView.frame = CGRectMake(titleX, titleY, LCScreenW, 35);
//    self.scrollView.frame = CGRectMake(0, 0, LCScreenW, LCScreenH);
    
}
@end
