//
//  LCSubTagCell.m
//  LCBudejie
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCSubTagCell.h"
#import "LCSubTagItem.h"

@interface LCSubTagCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
@implementation LCSubTagCell

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
- (void)setItem:(LCSubTagItem *)item
{
    _item = item;
    
    self.titleLabel.text = item.theme_name;
    
    [self setupSubTitle];
    
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        [path addClip];
//        
//        [image drawAtPoint:CGPointZero];
//        
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        self.iconView.image = image;
//    } ];
    [self.iconView lc_setHeaderImage:item.image_list placeholder:@"defaultUserIcon"];
}

- (void)setupSubTitle
{
   NSString *subStr = [NSString stringWithFormat:@"%@人订阅", _item.sub_number];
    double numb = [_item.sub_number intValue];
    
    if (numb > 10000)
    {
        numb = numb / 10000.0f;
        subStr = [NSString stringWithFormat:@"%.1f万人订阅", numb];
        [subStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.subTitleLabel.text = subStr;
}
//- (void)awakeFromNib
//{
//    self.iconView.layer.cornerRadius = 30;
//    self.iconView.layer.masksToBounds = YES;
//}
@end
