//
//  LCTabBar.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTabBar.h"
@interface LCTabBar()

@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, weak) UIControl *seleTabBarButton;

@end
@implementation LCTabBar

- (UIButton *)plusButton
{
    if (_plusButton == nil)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button  setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        [button sizeToFit];
        _plusButton = button;
    }
    return _plusButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.items.count;
    
    
    CGFloat viewX;
    CGFloat viewY = 0;
    CGFloat viewW = self.frame.size.width / (count + 1);
    CGFloat viewH = self.frame.size.height;
    int i = 0;
    for (UIControl *tabButton in self.subviews)
    {
        if ([tabButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            if (i == 0 && self.seleTabBarButton == nil)
            {
                self.seleTabBarButton = tabButton;
            }
            if (i == 2)
            {
                i+=1;
            }
            viewX = i * viewW;
            tabButton.frame = CGRectMake(viewX, viewY, viewW, viewH);
            
            i++;
            
            [tabButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if ( self.seleTabBarButton == tabBarButton)
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LCTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.seleTabBarButton = tabBarButton;
}
@end
