//
//  UIImageView+LCDownload.m
//  LCBudejie
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "UIImageView+LCDownload.h"
#import <AFNetworkReachabilityManager.h>
#import <UIImageView+WebCache.h>
@implementation UIImageView (LCDownload)
- (void)lc_setOriginImage:(NSString *)originImageURL  thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    
    
    if(originImage)
    {
        self.image = originImage;
        completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageURL]);
    }
    else
    {
        if (manager.isReachableViaWiFi)
        {
            // 加载大图片
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
        }else if(manager.isReachableViaWWAN)
        {
            BOOL downloadOriginImageWhen3G4G = YES;
            if(downloadOriginImageWhen3G4G)
            {
                //加载高清图片
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
            }else
            {
                //加载小图片
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            }
        }else//没有可用网络
        {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if(thumbnailImage)
            {
                // 加载小图片
                self.image = thumbnailImage;
                completedBlock(thumbnailImage, nil, 0, [NSURL URLWithString:thumbnailImageURL]);
            }else
            {
                //加载占位图片
                self.image = placeholder;
            }
        }
    }
}

- (void)lc_setHeaderImage:(NSString *)headerImageName placeholder:(NSString *)placehoder
{
    UIImage *placeholder = [UIImage lc_circleImageNamed:placehoder];
    
    [self sd_setImageWithURL:[NSURL URLWithString:headerImageName] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image lc_circleImage];
    }];
    
//    [self sd_setImageWithURL:[NSURL URLWithString:headerImageName] placeholderImage:[UIImage imageNamed:placehoder]];
}
@end
