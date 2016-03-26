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
   
//    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image2] placeholderImage:nil];
    
    self.backgroundImageView.hidden = NO;
    [self.voiceImageView lc_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.backgroundImageView.hidden = YES;
    }];
//    UIImage *placeholder = nil;
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
//    
//    
//        if(originImage)
//    {
//        self.voiceImageView.image = originImage;
//    }
//    else
//    {
//        if (manager.isReachableViaWiFi)
//        {
//           // 加载大图片
//            [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
//        }else if(manager.isReachableViaWWAN)
//        {
//            BOOL downloadOriginImageWhen3G4G = YES;
//            if(downloadOriginImageWhen3G4G)
//            {
//                //加载高清图片
//                [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
//            }else
//            {
//                //加载小图片
//                [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholder];
//            }
//        }else//没有可用网络
//        {
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
//            if(thumbnailImage)
//            {
//               // 加载小图片
//                self.voiceImageView.image = thumbnailImage;
//            }else
//            {
//                //加载占位图片
//                self.voiceImageView.image = placeholder;
//            }
//        }
//    }
//    
    
    // 占位图片
 /*   UIImage *placeholder = nil;
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
    if (originImage) { // 原图已经被下载过
        self.voiceImageView.image = originImage;
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
        } else if (mgr.isReachableViaWWAN) {
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
            } else {
                [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholder];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
            if (thumbnailImage) { // 缩略图已经被下载过
                self.voiceImageView.image = thumbnailImage;
            } else { // 没有下载过任何图片
                // 占位图片;
                self.voiceImageView.image = placeholder;
            }
        }
    }*/
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
