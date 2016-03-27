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
//#import <AddressBook/AddressBook.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
@interface LCSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation LCSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;

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
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized)
        {
            [self saveImageIntoAlbum];
        }else if (status == PHAuthorizationStatusDenied)
        {
            if (oldStatus != PHAuthorizationStatusNotDetermined)
            {
                NSLog(@"请打开相册");
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请稍后再试"];
        }
    }];
}

- (void)saveImageIntoAlbum
{
    // 获得相片
    PHFetchResult<PHAsset *> * createdAssets = [self createdAssets];
    if (createdAssets == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败!"];
        return;
    }
    
    //2. 获得相册
    PHAssetCollection *collection = [self createdCollection];
    if (collection == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"获得相册失败!"];
        return;
    }
    
    //3. 将相片存入自定义相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if (error)
    {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败!"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功!"];
    }
  
   
}
/**
 *  获取保存的图片
 *
 *  @return <#return value description#>
 */
- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    //1. 将图片存入相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } error:&error];
    if (error) return nil;
    
    // 抓取图片
   return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
/**
 *  获取相册
 *
 *  @return <#return value description#>
 */
- (PHAssetCollection *)createdCollection
{
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
   
    // 抓取自定义相册
  PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType: PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections)
    {
        if ([collection.localizedTitle isEqualToString:title])
        {
            return collection;
        }
    }
    // 如果没有就自己创建
    NSError *error = nil;
   __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
      createdCollectionID =  [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}
@end
