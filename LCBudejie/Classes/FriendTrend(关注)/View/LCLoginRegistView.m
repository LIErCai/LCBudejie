//
//  LCLoginRegistView.m
//  LCBudejie
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCLoginRegistView.h"
@interface LCLoginRegistView()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation LCLoginRegistView


+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
     return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    UIImage *image = self.loginButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginButton setBackgroundImage:image forState:UIControlStateNormal];
}
@end
