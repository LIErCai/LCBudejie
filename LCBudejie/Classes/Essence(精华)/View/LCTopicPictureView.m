//
//  LCTopicPictureView.m
//  LCBudejie
//
//  Created by admin on 16/3/24.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTopicPictureView.h"
#import "LCTopic.h"
#import <UIImageView+WebCache.h>
#import  <AFNetworking.h>
#import <UIImage+GIF.h>
@interface LCTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageVIew;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end
@implementation LCTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    UIImage *placeholderImage = nil;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
    if (originImage)
    {
        self.pictureImageVIew.image = originImage;
    }else
    {
        if (manager.isReachableViaWiFi)
        {
            [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholderImage];
        }else if(manager.isReachableViaWWAN)
        {
            BOOL downloadWith3Gor4G = YES;
            if (downloadWith3Gor4G)
            {
                [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholderImage];
            }else
            {
                [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholderImage];
            }
        }else
        {
            UIImage *thumImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
            if(thumImage)
            {
                self.pictureImageVIew.image = thumImage;
            }else
            {
                self.pictureImageVIew.image = placeholderImage;
            }
        }
    }
//    [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil];
    if ([topic.image1 containsString:@"gif"])
    {
        self.gifImageView.hidden = NO;
      
    }else
    {
        self.gifImageView.hidden = YES;
    }
}
@end
