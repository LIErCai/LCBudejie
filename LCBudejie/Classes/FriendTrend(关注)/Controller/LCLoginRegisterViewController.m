//
//  LCLoginRegisterViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCLoginRegisterViewController.h"
#import "LCLoginRegistView.h"
#import "LCFastLoginRegistView.h"
@interface LCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation LCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMiddleView];
    [self setupBottomView];
}

- (void)setupMiddleView
{
    LCLoginRegistView *loginView = [LCLoginRegistView loginView];
    [self.middleView addSubview:loginView];
    
    LCLoginRegistView *registerView = [LCLoginRegistView registerView];
    [self.middleView addSubview:registerView];
}

- (void)setupBottomView
{
    LCFastLoginRegistView *fastLoginView = [LCFastLoginRegistView fastLoginRegistView];
    [self.bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat w = self.middleView.lc_width * 0.5;
    CGFloat h = self.middleView.lc_height;
    LCLoginRegistView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, w , h);
    
    LCLoginRegistView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(w , 0, w, h);
    
    LCFastLoginRegistView *fastLoginView = self.bottomView.subviews[0];
    fastLoginView.frame = CGRectMake(0, 0, self.bottomView.lc_width, self.bottomView.lc_height);
}
- (IBAction)closeBtnClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)rightRegisterClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.leadCons.constant = _leadCons.constant == 0? -self.middleView.lc_width * 0.5: 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
