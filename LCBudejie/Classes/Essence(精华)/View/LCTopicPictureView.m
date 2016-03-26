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
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
@implementation LCTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    
    self.backgroundImageView.hidden = NO;
    [self.pictureImageVIew lc_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.backgroundImageView.hidden = YES;
    }];
//    UIImage *placeholderImage = nil;
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
//    if (originImage)
//    {
//        self.pictureImageVIew.image = originImage;
//    }else
//    {
//        if (manager.isReachableViaWiFi)
//        {
//            [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholderImage];
//        }else if(manager.isReachableViaWWAN)
//        {
//            BOOL downloadWith3Gor4G = YES;
//            if (downloadWith3Gor4G)
//            {
//                [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholderImage];
//            }else
//            {
//                [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholderImage];
//            }
//        }else
//        {
//            UIImage *thumImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
//            if(thumImage)
//            {
//                self.pictureImageVIew.image = thumImage;
//            }else
//            {
//                self.pictureImageVIew.image = placeholderImage;
//            }
//        }
//    }
//    [self.pictureImageVIew sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil];
    self.gifImageView.hidden = !topic.is_gif;
    
    if (topic.isBigImage)
    {
        self.seeBigImageButton.hidden = NO;
        self.pictureImageVIew.contentMode = UIViewContentModeTop;
        self.pictureImageVIew.clipsToBounds = YES;
        if (self.pictureImageVIew.image)
        {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.pictureImageVIew.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.pictureImageVIew.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
      
    }else
    {
        self.seeBigImageButton.hidden = YES;
        self.pictureImageVIew.contentMode = UIViewContentModeScaleToFill;
        self.pictureImageVIew.clipsToBounds = NO;
    }
}
@end
