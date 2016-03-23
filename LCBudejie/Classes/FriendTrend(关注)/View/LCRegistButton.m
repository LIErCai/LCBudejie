//
//  LCRegistButton.m
//  LCBudejie
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCRegistButton.h"

@implementation LCRegistButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.lc_y = 0;
    self.imageView.lc_centerX = self.lc_width * 0.5;
    
    self.titleLabel.lc_y = self.lc_height - self.titleLabel.lc_height;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.lc_centerX = self.lc_width * 0.5;
}

@end
