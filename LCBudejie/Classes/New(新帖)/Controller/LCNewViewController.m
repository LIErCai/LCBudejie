//
//  LCNewViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCNewViewController.h"
#import "UIBarButtonItem+LC.h"
#import "LCRecomViewController.h"
#import "LCTitleButton.h"

#import "LCAllViewController.h"
#import "LCVideoViewController.h"
#import "LCSoundViewController.h"
#import "LCPictureViewController.h"
#import "LCPieceViewController.h"

@interface LCNewViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) LCTitleButton *seleButton;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIView *titleLineView;

@end
@implementation LCNewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setBarItem];
    
    //添加所有子控制器
    [self setupAllChildControllers];
    
    //设置子控制器要展示的Scrollview;
    [self setupContentScrollView];
    // 设置标题view
    [self setupTitlesView];
    
    [self addChildVcViewIntoScrollView:0];
}
/**
 *  设置子控制器要展示的Scrollview;
 */
- (void)setupContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.frame = self.view.bounds;
        contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    contentScrollView.delegate = self;
    contentScrollView.scrollsToTop = NO;
//    NSInteger count = self.childViewControllers.count;
//    for (int i = 0; i < count; i++)
//    {
//        UIView *childView = self.childViewControllers[i].view;
//        childView.frame = CGRectMake(i * LCScreenW, 0, LCScreenW, LCScreenH);
//        [self.contentScrollView addSubview:childView];
//    }

    contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * LCScreenW, 0);

}


/**
 *   添加所有子控制器
 */
- (void)setupAllChildControllers
{
    [self addChildViewController:[[LCAllViewController alloc] init]];
    [self addChildViewController:[[LCVideoViewController alloc] init]];
    [self addChildViewController:[[LCSoundViewController alloc] init]];
    [self addChildViewController:[[LCPictureViewController alloc] init]];
    [self addChildViewController:[[LCPieceViewController alloc] init]];
}

/**
 *  设置标题view
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, LCNavMaxY, LCScreenW, LCTitleViewH);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self setupTitleButton];
    
    [self setupTitlesLine];
    

}


- (void)setupTitlesLine
{
    LCTitleButton *button = self.titlesView.subviews.firstObject;
    [button.titleLabel sizeToFit];
    UIView *titleLine = [[UIView alloc] init];
    titleLine.lc_height = 1;
    titleLine.lc_y = self.titlesView.lc_height - titleLine.lc_height;
    titleLine.lc_width = button.titleLabel.lc_width;
    titleLine.lc_centerX = button.lc_centerX;
    button.selected = YES;
    self.seleButton = button;
    titleLine.backgroundColor = [button titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleLine];
    self.titleLineView = titleLine;
}
- (void)setupTitleButton
{
    NSArray * titleButtons = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titleButtons.count;
    CGFloat buttonX;
    CGFloat buttonY = 0;
    CGFloat buttonW = LCScreenW / count;
    CGFloat buttonH = self.titlesView.lc_height;
    for (int i = 0; i < count; i++)
    {
        buttonX = i * buttonW;
        LCTitleButton *button = [[LCTitleButton alloc] init];
        button.tag = i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setTitle:titleButtons[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.titlesView addSubview:button];
    }
}

- (void)titleButtonClicked:(LCTitleButton *)button
{
    
    if (self.seleButton == button)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LCTitleButtonDidRepeatClickNotification object:nil];
    }
    self.seleButton.selected = NO;
    button.selected = YES;
    self.seleButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.titleLineView.lc_width = button.titleLabel.lc_width;
        self.titleLineView.lc_centerX = button.lc_centerX;
    }];
    NSInteger i = button.tag;
    
    [self addChildVcViewIntoScrollView:i];
    
    NSInteger count = self.childViewControllers.count;
    for (int index = 0; index < count; index++)
    {
        UIViewController *vc = self.childViewControllers[index];
        if (!vc.isViewLoaded) continue;
        UIView *view = vc.view;
        if (![view isKindOfClass:[UIScrollView class]]) continue;
        UIScrollView *scrollView = (UIScrollView *)view;
       
            scrollView.scrollsToTop = (index == i);
        
        
    }
}
/**
 *  设置导航栏
 */
- (void)setBarItem
{
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.image = [UIImage imageNamed:@"MainTitle"];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
       self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hightImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(subIconClick)];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / LCScreenW + 0.5;
    [self titleButtonClicked:self.titlesView.subviews[i]];
}

- (void)subIconClick
{
    LCRecomViewController *recomVc = [[LCRecomViewController alloc] init];
    [self.navigationController pushViewController:recomVc animated:YES];
}

- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
//    if (childVc.isViewLoaded) return;
    UIView *childVcView = childVc.view;
    childVcView.frame = CGRectMake(index * LCScreenW, 0, LCScreenW, LCScreenH);
    [self.contentScrollView addSubview:childVcView];
    [self.contentScrollView setContentOffset:CGPointMake(index * LCScreenW, self.contentScrollView.contentOffset.y) animated:YES];
}
@end
