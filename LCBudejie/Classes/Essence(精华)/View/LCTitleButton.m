//
//  LCTitleButton.m
//  LCBudejie
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTitleButton.h"

@implementation LCTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{

}
@end
