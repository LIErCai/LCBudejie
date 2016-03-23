//
//  LCFriendTrendViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCFriendTrendViewController.h"
#import "UIBarButtonItem+LC.h"
#import "LCLoginRegisterViewController.h"
@interface LCFriendTrendViewController()

@property (weak, nonatomic) IBOutlet UIButton *fastRegistButton;

@end
@implementation LCFriendTrendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImage *imageNormal = [UIImage imageNamed: @"friendsTrend_login"];
//    imageNormal = [imageNormal stretchableImageWithLeftCapWidth:imageNormal.size.width  topCapHeight:imageNormal.size.height];
//    [self.fastRegistButton setBackgroundImage:imageNormal forState:UIControlStateNormal];
//    UIImage *imageHight = [UIImage imageNamed:@"friendsTrend_login_click"];
//    imageHight = [imageHight stretchableImageWithLeftCapWidth:imageHight.size.width  topCapHeight:imageHight.size.height];
//    [self.fastRegistButton setBackgroundImage:imageHight forState:UIControlStateHighlighted];
//    
    [self setBarItem];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
   UIImage *image  = self.fastRegistButton.currentBackgroundImage;
    image = [image   stretchableImageWithLeftCapWidth:image.size.width * 0.5 - 1 topCapHeight:image.size.height * 0.5 - 1];
}
- (IBAction)fastRegistButton:(id)sender {
    
    LCLoginRegisterViewController *loginRegistVc = [[LCLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegistVc animated:YES completion:nil];

}

- (void)setBarItem
{
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] hightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(friendsRecommentIconClick)];
    
    
}

- (void)friendsRecommentIconClick
{
    }
@end
