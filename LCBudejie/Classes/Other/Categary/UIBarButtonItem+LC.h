//
//  UIBarButtonItem+LC.h
//  LCBudejie
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LC)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage  addTarget:(id)target action:( SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage addTarget:(id)target action:( SEL)action;

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage addTarget:(id)target action:( SEL)action title:(NSString *)title;
@end
