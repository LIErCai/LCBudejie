//
//  LCTopicVoiceView.m
//  LCBudejie
//
//  Created by admin on 16/3/24.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTopicVoiceView.h"
#import "LCTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
@interface LCTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
@implementation LCTopicVoiceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
   
 self.backgroundImageView.hidden = NO;
    [self.voiceImageView lc_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.backgroundImageView.hidden = YES;
    }];

       NSLog(@"%@", self.voiceImageView.image);
    NSString *playCountStr;
    NSInteger count = topic.playcount;
    if (count >= 10000)
    {
        playCountStr = [NSString stringWithFormat:@"%.1f万播放", count / 10000.0];
    }else
    {
        playCountStr = [NSString stringWithFormat:@"%zd播放", count];
    }
    self.playCountLabel.text = playCountStr;
    
     self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}

@end
