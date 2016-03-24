//
//  UIImage+LC.h
//  LCBudejie
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LC)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName;
+ (instancetype)lc_circleImageNamed:(NSString *)imageName;

- (instancetype)lc_circleImage;
@end
