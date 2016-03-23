//
//  LCLoginTextField.m
//  LCBudejie
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCLoginTextField.h"
#import "UITextField+Placeholder.h"
@implementation LCLoginTextField

- (void)awakeFromNib
{
    //1. 设置占位文字颜色
    self.placeholderColor = [UIColor lightGrayColor];
    
    //2. 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.rightView setBackgroundColor:[UIColor whiteColor]];
    //3.监听textfield的改变
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
}

- (void)textEnd
{
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
