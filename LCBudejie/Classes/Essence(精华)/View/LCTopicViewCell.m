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

#import "LCTopicPictureView.h"
#import "LCTopicVideoView.h"
#import "LCTopicVoiceView.h"
@interface LCTopicViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topicCommitView;
@property (weak, nonatomic) IBOutlet UILabel *topicCommitLabel;


@property (nonatomic, strong) LCTopicPictureView *pictureView;
@property (nonatomic, strong) LCTopicVideoView *videoView;
@property (nonatomic, strong) LCTopicVoiceView *voiceView;

@end
@implementation LCTopicViewCell
- (LCTopicVoiceView *)voiceView
{
    if (_voiceView == nil)
    {
        _voiceView = [LCTopicVoiceView lc_viewFromXib];
        [self addSubview:_voiceView];
    }
    return _voiceView;
}

- (LCTopicVideoView *)videoView
{
    if (_videoView == nil)
    {
        _videoView = [LCTopicVideoView lc_viewFromXib];
           [self addSubview:_videoView];
    }
    return _videoView;
}

- (LCTopicPictureView *)pictureView
{
    if (_pictureView == nil)
    {
        _pictureView = [LCTopicPictureView lc_viewFromXib];
           [self addSubview:_pictureView];
    }
    return _pictureView;
}
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.passtime;
    self.text_label.text = topic.text;


    [self.profileImageView lc_setHeaderImage:topic.profile_image placeholder:@"defaultUserIcon"];

    [self setTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setTitle:self.repostButton number:topic.repost placeholder:@"转"];
    [self setTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    if(topic.top_cmt.count)
    {
        self.topicCommitView.hidden = NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0)
        {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.topicCommitLabel.text = [NSString stringWithFormat:@"%@ : %@", content, username];
    }else
    {
        self.topicCommitView.hidden = YES;
    }
    
    if (topic.type == LCTopicTypePicture)
    {
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (topic.type == LCTopicTypeVoice)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
    }else if (topic.type == LCTopicTypeVideo)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.voiceView.hidden = YES;
    }else if(topic.type == LCTopicTypeWord)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.topic.type == LCTopicTypePicture)
    {
        self.pictureView.frame = self.topic.middleFrame;
    }else  if(self.topic.type == LCTopicTypeVideo)
    {
        self.videoView.frame = self.topic.middleFrame;
    }else if(self.topic.type == LCTopicTypeVoice)
    {
        self.voiceView.frame = self.topic.middleFrame;
    }
   
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
