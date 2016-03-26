//
//  UIImageView+LCDownload.h
//  LCBudejie
//
//  Created by admin on 16/3/26.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
@interface UIImageView (LCDownload)

- (void)lc_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

- (void)lc_setHeaderImage:(NSString *)headerImageName placeholder:(NSString *)placehoder;
@end
