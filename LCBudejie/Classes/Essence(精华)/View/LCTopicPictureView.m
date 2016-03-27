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
#import "LCSeeBigPictureViewController.h"
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
    self.pictureImageVIew.userInteractionEnabled = YES;
    [self.pictureImageVIew addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}



- (IBAction)seeBigPicture
{
    LCSeeBigPictureViewController *vc = [[LCSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}
- (void)setTopic:(LCTopic *)topic
{
    _topic = topic;
    
    self.backgroundImageView.hidden = NO;
    [self.pictureImageVIew lc_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.backgroundImageView.hidden = YES;
        if (topic.isBigImage)
        {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.pictureImageVIew.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.pictureImageVIew.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }

    }];

    self.gifImageView.hidden = !topic.is_gif;
    
    if (topic.isBigImage)
    {
        self.seeBigImageButton.hidden = NO;
        self.pictureImageVIew.contentMode = UIViewContentModeTop;
        self.pictureImageVIew.clipsToBounds = YES;
        
    }else
    {
        self.seeBigImageButton.hidden = YES;
        self.pictureImageVIew.contentMode = UIViewContentModeScaleToFill;
        self.pictureImageVIew.clipsToBounds = NO;
    }
}
@end
