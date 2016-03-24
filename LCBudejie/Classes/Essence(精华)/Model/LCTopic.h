//
//  LCTopic.h
//  LCBudejie
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LCTopicType) {
    LCTopicTypeAll = 1,
    LCTopicTypePicture = 10,
    LCTopicTypeWord = 29,
    LCTopicTypeVoice = 31,
    LCTopicTypeVideo = 41
};


@interface LCTopic : NSObject
/**用户名字*/
@property (nonatomic, strong) NSString *name;
/**用户头像*/
@property (nonatomic, strong) NSString *profile_image;
/**帖子的中文*/
@property (nonatomic, strong) NSString *text;
/**帖子审核通过时间*/
@property (nonatomic, strong) NSString *passtime;
/**赞数*/
@property (nonatomic, strong) NSString *ding;
/**踩数*/
@property (nonatomic, strong) NSString *cai;
/**转发数*/
@property (nonatomic, strong) NSString *repost;
/**评论数*/
@property (nonatomic, strong) NSString *comment;
/**要显示的cell的类型*/
@property (nonatomic, assign) NSInteger type;

/**小图*/
@property (nonatomic, strong) NSString *image0;
/**中图*/
@property (nonatomic, strong) NSString *image2;
/**大图*/
@property (nonatomic, strong) NSString *image1;
/**音频时长*/
@property (nonatomic, assign) NSInteger voicetime;
/**视频时长*/
@property (nonatomic, assign) NSInteger videotime;
/**播放次数*/
@property (nonatomic, assign) NSInteger playcount;

/**图片的高度*/
@property (nonatomic, assign) CGFloat height;
/**图片的宽度*/
@property (nonatomic, assign) CGFloat width;
/**最热评论*/
@property (nonatomic, strong) NSArray *top_cmt;

/**每行cell的高度*/
@property (nonatomic, assign) CGRect middleFrame;

/**的高度*/
@property (nonatomic, assign) CGFloat rowHeight;
@end
