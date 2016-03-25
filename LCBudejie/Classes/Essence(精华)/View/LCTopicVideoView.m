//
//  LCTopicVideoView.m
//  LCBudejie
//
//  Created by admin on 16/3/24.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTopicVideoView.h"
#import "LCTopic.h"
#import <UIImageView+WebCache.h>
@interface LCTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *videoplaycountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@end
@implementation LCTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil];
    if (topic.playcount >= 10000)
    {
        self.videoplaycountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    }else
    {
        self.videoplaycountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%zd : %zd", topic.videotime/60, topic.videotime % 60];
}
@end
