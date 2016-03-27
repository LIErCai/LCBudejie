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
#import "LCSeeBigPictureViewController.h"
@interface LCTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *videoplaycountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
@implementation LCTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.videoImageView.userInteractionEnabled = YES;
    [self.videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}



- (void)seeBigPicture
{
    LCSeeBigPictureViewController *vc = [[LCSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    self.backgroundImageView.hidden = NO;
    [self.videoImageView lc_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.backgroundImageView.hidden = YES;
    }];
    
//    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil];
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
