//
//  LCFastLoginRegistView.m
//  LCBudejie
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCFastLoginRegistView.h"

@implementation LCFastLoginRegistView

+ (instancetype)fastLoginRegistView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LCFastLoginRegistView" owner:nil options:nil] lastObject];
}

@end
