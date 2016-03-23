//
//  LCPictureViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCPictureViewController.h"

@interface LCPictureViewController ()

@end

@implementation LCPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.view.backgroundColor = [UIColor darkGrayColor];
    
     self.tableView.contentInset = UIEdgeInsetsMake(LCNavMaxY + LCTitleViewH, 0, LCTabBarH, 0);
    
     self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:LCTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:LCTitleButtonDidRepeatClickNotification object:nil];
    
    NSLog(@"%s", __func__);
}

- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
   NSLog(@"刷新%@", [self class]);

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end
