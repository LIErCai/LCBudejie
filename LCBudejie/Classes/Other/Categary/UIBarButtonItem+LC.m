//
//  UIBarButtonItem+LC.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "UIBarButtonItem+LC.h"

@implementation UIBarButtonItem (LC)


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage addTarget:(id)target action:( SEL)action
{
    UIButton *btn = [[UIButton  alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    UIView *view = [[UIView alloc] init];
    [view addSubview:btn];
    view.frame = btn.bounds;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage addTarget:(id)target action:( SEL)action
{
    UIButton *btn = [[UIButton  alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn sizeToFit];
    UIView *view = [[UIView alloc] init];
    [view addSubview:btn];
    view.frame = btn.bounds;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:view];
    
}
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage addTarget:(id)target action:( SEL)action title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hightImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [button sizeToFit];
    [button  addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] init];
    [view addSubview:button];
     view.frame = button.bounds;
   return [[UIBarButtonItem alloc] initWithCustomView:view];
}
@end
