//
//  UITextField+Placeholder.m
//  LCBudejie
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>
@implementation UITextField (Placeholder)


//+ (void)load
//{
//    
//}
/**
 *  为系统的私有类添加方法
 *
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
//    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //获取占位文字的label控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    if (placeholderColor == nil) {
        self.placeholder = @" ";
        placeholderLabel = [self valueForKey:@"placeholderLabel"];
    }
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
@end
