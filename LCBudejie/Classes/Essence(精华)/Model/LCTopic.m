//
//  LCTopic.m
//  LCBudejie
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "LCTopic.h"

@implementation LCTopic

- (CGFloat)rowHeight
{
    
    if(_rowHeight) return _rowHeight;
    _rowHeight += 55;
    //text的高度
    CGSize textMaxSize = CGSizeMake(LCScreenW - 2 * LCMargin, MAXFLOAT);
   _rowHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + LCMargin;
    
    //图片的高度
    if (self.type != LCTopicTypeWord)
    {
        // x  x
        // y  y
        CGFloat middleX = LCMargin;
        CGFloat middleY = _rowHeight;
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        
        if (middleH >= LCScreenH)
        {
            middleH = 200;
            self.bigImage = YES;
        }else
        {
            self.bigImage = NO;
        }
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _rowHeight += middleH + LCMargin;
    }
    
    //最热评论
    if (self.top_cmt.count)
    {
        _rowHeight += 20;
        
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0)
        {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _rowHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + LCMargin;
    }
    //工具条
    _rowHeight += 35 + LCMargin;
    
    return _rowHeight;
}
@end
