//
//  UIView+LCFrame.m
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "UIView+LCFrame.h"

@implementation UIView (LCFrame)

+ (instancetype)lc_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setLc_height:(CGFloat)lc_height
{
    CGRect rect = self.frame;
    rect.size.height = lc_height;
    self.frame = rect;
}

- (CGFloat)lc_height
{
    return self.frame.size.height;
}
- (void)setLc_width:(CGFloat)lc_width
{
    CGRect rect = self.frame;
    rect.size.width = lc_width;
    self.frame = rect;

}
- (CGFloat)lc_width
{
    return self.frame.size.width;
}
- (void)setLc_x:(CGFloat)lc_x
{
    CGRect rect = self.frame;
    rect.origin.x = lc_x;
    self.frame = rect;

}
- (void)setLc_y:(CGFloat)lc_y
{
    CGRect rect = self.frame;
    rect.origin.y = lc_y;
    self.frame = rect;
}
- (CGFloat)lc_x
{
    return self.frame.origin.x;
}
- (CGFloat)lc_y
{
    return  self.frame.origin.y;
}

- (void)setLc_centerX:(CGFloat)lc_centerX
{
    CGPoint center = self.center;
    center.x = lc_centerX;
    self.center = center;
}

- (CGFloat)lc_centerX
{
    return self.center.x;
}
- (void)setLc_centerY:(CGFloat)lc_centerY
{
    CGPoint center = self.center;
    center.y = lc_centerY;
    self.center = center;
}

- (CGFloat)lc_centerY
{
    return self.center.y;
}
@end
