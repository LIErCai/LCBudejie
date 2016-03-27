//
//  LCSeeBigPictureViewController.m
//  LCBudejie
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCSeeBigPictureViewController.h"
#import "LCTopic.h"
#import <UIImageView+WebCache.h>
#import <AddressBook/AddressBook.h>
@interface LCSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation LCSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageview = [[UIImageView alloc] init];
  
    [imageview sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.saveButton.enabled = YES;
    }];
    imageview.lc_width = scrollView.lc_width;
    imageview.lc_height = imageview.lc_width * self.topic.height / self.topic.width;
    imageview.lc_x = 0;
    if (imageview.lc_height > LCScreenH)
    {
        scrollView.contentSize = CGSizeMake(0, imageview.lc_height);
        imageview.lc_y = 0;
    }else
    {
        imageview.lc_centerY = scrollView.lc_height * 0.5;
    }
      self.imageView = imageview;
    [scrollView addSubview:imageview];
    
    CGFloat scale = self.topic.width / imageview.lc_width;
    if (scale > 1)
    {
        scrollView.maximumZoomScale = scale;
        scrollView.delegate = self;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"保存成功");
}


@end
