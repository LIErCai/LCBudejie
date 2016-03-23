//
//  LCTopicViewCell.m
//  LCBudejie
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTopicViewCell.h"
#import "LCTopic.h"
#import <UIImageView+WebCache.h>
@interface LCTopicViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
@implementation LCTopicViewCell

+ (instancetype)topicCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"cell";
    LCTopicViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCTopicViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
#warning 头像处理---
    }];
//    [self.dingButton setTitle:topic.ding forState:UIControlStateNormal];
    
    [self setTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setTitle:self.repostButton number:topic.repost placeholder:@"转"];
    [self setTitle:self.commentButton number:topic.comment placeholder:@"评论"];
//     [self.caiButton setTitle:topic.cai forState:UIControlStateNormal];
//     [self.repostButton setTitle:topic.repost forState:UIControlStateNormal];
//     [self.commentButton setTitle:topic.comment forState:UIControlStateNormal];
    
//    self.dingButton.titleLabel.text = [NSString stringWithFormat:@"%@",topic.ding];
//    self.caiButton.titleLabel.text = topic.cai;
//    self.repostButton.titleLabel.text = topic.repost;
//    self.commentButton.titleLabel.text = topic.comment;
}


- (void)setTitle:(UIButton *)button number:(NSString *)numberStr placeholder:(NSString *)placeholder
{
      NSInteger number = [numberStr integerValue];
    if (number >= 10000)
    {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/ 10000.0] forState:UIControlStateNormal];
    }else if(number > 0)
    {
        [button  setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}
@end
