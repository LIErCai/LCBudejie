//
//  LCTabBarController.m
//  LCBudejie
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTabBarController.h"
#import "UIImage+LC.h"
#import "LCTabBar.h"
#import "LCNavigationController.h"

#import "LCEssenceViewController.h"
#import "LCNewViewController.h"
#import "LCPublishViewController.h"
#import "LCFriendTrendViewController.h"
#import "LCMineViewController.h"

@implementation LCTabBarController

+ (void)load
{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    selAttr[NSForegroundColorAttributeName] = [UIColor  blackColor];
    [item setTitleTextAttributes:selAttr forState:UIControlStateSelected];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1. 加载子控制器
    [self setupAllChilderController];
    
    [self setValue:[[LCTabBar alloc] init] forKey:@"tabBar"];
 
    
}

/**
 *  加载所有子控制器
 */
- (void)setupAllChilderController
{
    //1.精华
    LCEssenceViewController *essenceVc = [[LCEssenceViewController alloc] init];
    [self addOneController:essenceVc title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectImage:[UIImage imageOriginalWithName:@"tabBar_essence_click_icon"]];
   
    //2. 新帖
    LCNewViewController  *newVc = [[LCNewViewController alloc] init];
    [self addOneController:newVc title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selectImage:[UIImage imageOriginalWithName:@"tabBar_new_click_icon"]];
    
  
    //4. 关注
    LCFriendTrendViewController  *friendVc = [[LCFriendTrendViewController alloc] init];
    [self addOneController:friendVc title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectImage:[UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"]];
    
    //5. 我
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([LCMineViewController class]) bundle:[NSBundle mainBundle]];
    LCMineViewController *meVc = [storyBoard instantiateInitialViewController];
    [self addOneController:meVc title:@"我" image:[UIImage imageNamed:@"tabBar_me_icon"] selectImage:[UIImage imageOriginalWithName:@"tabBar_me_click_icon"]];
}
/**
 *  加载所有一个控制器
 */
- (void)addOneController:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
    LCNavigationController *nav = [[LCNavigationController alloc] initWithRootViewController:vc];
    nav.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selectImage;
    [self addChildViewController:nav];

}
@end
