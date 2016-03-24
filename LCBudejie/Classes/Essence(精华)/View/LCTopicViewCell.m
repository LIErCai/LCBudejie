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

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    UIImage *placeholder = [UIImage lc_circleImageNamed:@"defaultUserIcon"];
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.profileImageView.image = [image lc_circleImage];
    }];

    
    [self setTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setTitle:self.repostButton number:topic.repost placeholder:@"转"];
    [self setTitle:self.commentButton number:topic.comment placeholder:@"评论"];

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
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
