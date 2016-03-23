//
//  LCSquareCell.m
//  LCBudejie
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCSquareCell.h"
#import "LCSquareItem.h"
#import <UIImageView+WebCache.h>
@interface LCSquareCell() 
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation LCSquareCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(LCSquareItem *)item
{
    _item = item;
    self.nameLabel.text = item.name;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
}
@end
