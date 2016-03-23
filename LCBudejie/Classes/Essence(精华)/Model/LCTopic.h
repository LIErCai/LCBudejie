//
//  LCTopic.h
//  LCBudejie
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
