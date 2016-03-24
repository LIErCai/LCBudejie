//
//  UIView+LCFrame.h
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCFrame)

@property CGFloat lc_width;
@property CGFloat lc_height;
@property CGFloat lc_x;
@property CGFloat lc_y;
@property CGFloat lc_centerX;
@property CGFloat lc_centerY;

+ (instancetype)lc_viewFromXib;
@end
