//
//  LCNavigationController.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCNavigationController.h"
#import "UIBarButtonItem+LC.h"
@interface LCNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LCNavigationController

+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attr];
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] hightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(returnClick) title:@"返回"];


    }
    [super pushViewController:viewController animated:animated];
}

- (void)returnClick
{
    [self popViewControllerAnimated:YES];
}

@end
